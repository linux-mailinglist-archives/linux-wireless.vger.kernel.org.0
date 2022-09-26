Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AF75EB079
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Sep 2022 20:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiIZSt2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Sep 2022 14:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiIZSt1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Sep 2022 14:49:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A28488DFA
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 11:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664218165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0LEzoipDzoru5BZ1IIOpL/p338KJGh9e0r8cRS5PNUA=;
        b=MnxgcQC4gH3fN2jxaRmB6/ZQbugPTbNnrvD56a4Llux5r/YfbfThdBBjcDvgvrXsW5lsBD
        pP9d0tHsZrqmq+Ww9xGWsIYFOTcrWvT5GR+j9tnnhYgSYw6CHjDXkhomeOiySGihLYFtht
        5M2RsuiRxMmQJKcnbP5ZtgxcpKkDRAk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149-F8q_BXxvOb2jKqpfVKMGdA-1; Mon, 26 Sep 2022 14:49:22 -0400
X-MC-Unique: F8q_BXxvOb2jKqpfVKMGdA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E99F101AA79;
        Mon, 26 Sep 2022 18:49:21 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9AACC492B05;
        Mon, 26 Sep 2022 18:49:19 +0000 (UTC)
From:   Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To:     jtornosm@redhat.com
Cc:     gregory.greenman@intel.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, pstourac@redhat.com
Subject: Re: [PATCH] iwlwifi: mvm: fix double list_add at iwl_mvm_mac_wake_tx_queue (other cases)
Date:   Mon, 26 Sep 2022 20:49:17 +0200
Message-Id: <20220926184917.6535-1-jtornosm@redhat.com>
In-Reply-To: <20220909121235.575541-1-jtornosm@redhat.com>
References: <20220909121235.575541-1-jtornosm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Could someone please review this patch?
This is just a second part of a previous patch already acked (14a3aacf517a9)

