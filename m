Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB496BD0CC
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Mar 2023 14:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjCPN1I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Mar 2023 09:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjCPN1H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Mar 2023 09:27:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B19A2ED51
        for <linux-wireless@vger.kernel.org>; Thu, 16 Mar 2023 06:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678973177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G0GjSNp14sgLvsRbIO2AGErzNaT8G3GbrNu8G+re4js=;
        b=EVqugp7ds14vfLclvX20KAs0QlvxaP923ARvWb+ciWUasbQJPAF0YAas6663yJeDSJbyLa
        eAhEt1gRXK95mx5R6JakcmtScJru3x64lY1qec1drOPOGDlHs06pAD8YL42JF6C9YLzrj/
        CpYBfd/mtDkfUjX0ZcfHapxN65rxRDw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-wQTMRmwWPAuq9cqMLyh5qw-1; Thu, 16 Mar 2023 09:26:14 -0400
X-MC-Unique: wQTMRmwWPAuq9cqMLyh5qw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C462885A588;
        Thu, 16 Mar 2023 13:26:13 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8995C492B00;
        Thu, 16 Mar 2023 13:26:12 +0000 (UTC)
From:   Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To:     johannes.berg@intel.com
Cc:     gregory.greenman@intel.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, pstourac@redhat.com,
        jtornosm@redhat.com
Subject: Re: [PATCH] iwlwifi: mvm: fix double list_add at iwl_mvm_mac_wake_tx_queue (roaming)
Date:   Thu, 16 Mar 2023 14:25:43 +0100
Message-Id: <20230316132543.37092-1-jtornosm@redhat.com>
In-Reply-To: <18728c67cffad35f827d9a32af34044592254093.camel@sipsolutions.net>
References: <18728c67cffad35f827d9a32af34044592254093.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

My previous solution was working with my test during one week with no problem
and now your more complete solution has been working during 2 days with no 
problem as well. I was able to reproduce in less time with my test, so your
solution is successfully verified and I can say: 

Tested-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

Thanks

