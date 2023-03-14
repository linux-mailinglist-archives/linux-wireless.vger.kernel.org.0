Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44D36B9855
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 15:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCNOwz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 10:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjCNOwy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 10:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C187A5926
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 07:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678805534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O8Dp9V4Jtnxv6LTvWmL+as7spdw0je+pSLGK7HN3Lxk=;
        b=Ek0XnueyX4H/w3QaQTF4mnF2+DlxgWtrwarxPpokKaGmSZWAMJjU+xLPU61F3fH9XPA/N3
        OBGfu5w32laUBhwRkE/DhaiJlzxPc8rYUlM4Zfz/H9w14IYRUU2RCbLqsti/BKnBE7XdMT
        8UgSpRx5m8UijaGtE08RADcJp/8LVEw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-jQhoG6pQPaermjvCjdZfMQ-1; Tue, 14 Mar 2023 10:52:13 -0400
X-MC-Unique: jQhoG6pQPaermjvCjdZfMQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1D601C02D30;
        Tue, 14 Mar 2023 14:52:12 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB2C54042AC5;
        Tue, 14 Mar 2023 14:52:10 +0000 (UTC)
From:   Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To:     johannes.berg@intel.com
Cc:     gregory.greenman@intel.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, pstourac@redhat.com
Subject: [PATCH] iwlwifi: mvm: fix double list_add at iwl_mvm_mac_wake_tx_queue (roaming)
Date:   Tue, 14 Mar 2023 15:52:09 +0100
Message-Id: <20230314145209.401875-1-jtornosm@redhat.com>
In-Reply-To: <20230314103840.30771-1-jtornosm@redhat.com>
References: <20230314103840.30771-1-jtornosm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

>> Issues like this, in scenarios with continuous roaming, have been reported:
> Can you say where? Any public reports?
We have some Bugzilla (i.e. 
https://bugzilla.redhat.com/show_bug.cgi?id=2152168).
You only have to create a user for this tool.

>> This can be reproduced with a single script from the station:
>>     while true; do
>>         wpa_cli -i wlp3s0 roam 34:13:E8:B1:DB:9A
>>         sleep 2
>>         wpa_cli -i wlp3s0 roam 34:13:E8:3C:FB:DB
>>         sleep 2
>>     done
>> And flooding with tx traffic.
>Oh, nice to have a reproducer.
It is not immediate but I can reproduce here like this.

> Funny thing is, I was _just_ looking at this exact bug, because we were
> discussing all this concurrency over in
So more people is struggling this this, good to get the best solution.

> https://lore.kernel.org/r/20230313201542.72325-1-alexander@wetzel-home.de

>> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
>> @@ -787,11 +787,18 @@ static void iwl_mvm_mac_wake_tx_queue(struct ieee80211_hw *hw,
>>               return;
>>       }
>>  
>> +     spin_lock_bh(&mvmtxq->list_lock);
>> +
>>       /* The list is being deleted only after the queue is fully allocated. */
>> -     if (!list_empty(&mvmtxq->list))
>> +     if (!list_empty(&mvmtxq->list)) {
>> +             spin_unlock_bh(&mvmtxq->list_lock);
>>               return;
>> +     }
>>  
>>       list_add_tail(&mvmtxq->list, &mvm->add_stream_txqs);
>> +
>> +     spin_unlock_bh(&mvmtxq->list_lock);


> While this might fix the issue as far as you could observe, that is
> clearly not sufficient, since you don't protect the list on the other
> side, where the items are removed from it again.
Ok, I thought about that as well but I was not able to find any problem with
the other side. Anyway, the better the solution is made the better.

> Below are the two patches that I've come up with so far, if anyone wants
> to try them. Please ignore all the extra metadata, I exported this
> directly from our internal code base.
Of course, I can test the soutions here in order to be sure.
Do you prefer I reply with the result here or in the other thread that you have
commented me before?

Thanks

Best regards
Jose Ignacio

