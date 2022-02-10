Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABD64B081A
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 09:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237267AbiBJI0o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 03:26:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237337AbiBJI0o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 03:26:44 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C8810AC
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 00:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=BWdBKr0BMEvyDGpuDAjvI9zYj+udQb6KNu2HHHuDpIc=;
        t=1644481605; x=1645691205; b=yOKdiPwdgBcjWZRFFoYxKPhmQSpBxUK9CeFbQxIGDw7cwQc
        UWBd/CThHQJuLV9UxPkDs+4vC2UeJkpr6kv8IocZbPMKcw4kutMPyI/gmlmesly3XGgFIzHwdjR2q
        Y6uwfi//2KmxdLm5uuEb6tbCdyLj0v0kHv1wlCUuy4AcT7loSwLCPEvYaSgwbviv3DW6nUjIw4Dge
        uCXuOpgsHpCvNs/uW0LL1pD3mZ5WL/FnRfH7pjGVFrEHlsJ67tm7QnH8jvAq3gYGWx2vyEPWAVm6/
        ih1bHfHDR4Xt3APBS5e8QxDnVWY5U3TO56KzgCVzI/ZG7gFgfq4Sqd4pGmPbfuWA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nI4mq-00GxlX-4O;
        Thu, 10 Feb 2022 09:26:44 +0100
Message-ID: <793a595932ea0adf7a72eeafb6ababdae8e21fc2.camel@sipsolutions.net>
Subject: Re: [PATCH 2/6] nl80211: add support to advertise driver's EHT
 capabilities
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Aloka Dixit (QUIC)" <quic_alokad@quicinc.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Vikram Kandukuri (QUIC)" <quic_vikram@quicinc.com>,
        "Jia Ding (QUIC)" <quic_jiad@quicinc.com>,
        "Karthikeyan Periyasamy (QUIC)" <quic_periyasa@quicinc.com>,
        "Muna Sinada (QUIC)" <quic_msinada@quicinc.com>,
        "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        "Veerendranath Jakkam (QUIC)" <quic_vjakkam@quicinc.com>,
        Aloka Dixit <alokad@qti.qualcomm.com>
Date:   Thu, 10 Feb 2022 09:26:42 +0100
In-Reply-To: <DM8PR02MB795853BB4B1C71B20857D2D3FE2F9@DM8PR02MB7958.namprd02.prod.outlook.com>
References: <1640163883-12696-1-git-send-email-quic_vjakkam@quicinc.com>
         <1640163883-12696-3-git-send-email-quic_vjakkam@quicinc.com>
         <DM8PR02MB795853BB4B1C71B20857D2D3FE2F9@DM8PR02MB7958.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2022-02-10 at 05:14 +0000, Aloka Dixit (QUIC) wrote:
> Hi Johannes,
> 
> Considering that 20MHz-only STA and one that supports other bandwidths will not occur at the same time,
> instead of a separate field for struct ieee80211_eht_mcs_nss_supp_20mhz_only inside struct ieee80211_eht_mcs_nss_supp, we can use a byte array as we added in here:
> https://patchwork.kernel.org/project/linux-wireless/patch/1640163883-12696-3-git-send-email-quic_vjakkam@quicinc.com/
> Instead of length field with dynamic allocation we can have an array of size 9 bytes.
> 

We did something like that in our patches:

https://patchwork.kernel.org/project/linux-wireless/patch/20220204230119.b0eeb527d761.I2413a37c8f7d2d6d638038a3d95360a3fce0114d@changeid/
https://patchwork.kernel.org/project/linux-wireless/patch/20220204230119.1ee92202ac30.Id30a3ef2844b296efbd5486fe1da9ca36a95c5cf@changeid/

Not overlapping wastes like 4 bytes of memory, I think I can live with
that, vs. the extra complexity? If you overlap you need another bit to
indicate which one you're using ...

johannes
