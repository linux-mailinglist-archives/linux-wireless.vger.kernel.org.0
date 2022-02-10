Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F44E4B12C1
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 17:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244190AbiBJQ3d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 11:29:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiBJQ3c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 11:29:32 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34E5104
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 08:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=WTXTWwaAIBwsMunw6kAc2lrKv8uJXTxPjU6DwTLdpmE=;
        t=1644510572; x=1645720172; b=OaQK4fnfxdiftGGYROPkxfgNmlBAWNMrugoy2/A9g26Rt5j
        0JRjL+crM0eq2bw1pUTa/6tO9x0CzhkGZbAYR2D/YN6y2mMH+u0Csy6g/LeeRICoGRHSSDWAhECRW
        E5v7coXskaWVVi8E3zKKd+cVH2jkstsm9KMWdLvUIoUYuik8lkxUfBIfaNlvFsdhA+szJSfT00CGN
        wCRRe4RbhPC14edaczYjoSgM9ZuvzJnXaOQ1eyUYT6YEBuvgVcDrywLZqJHCjzVSYAQ0tOcE9uPiR
        sz5ptXVn00Y3YqvZtlxMg7AwX38u0mLbBu3VyoVI3VWWP3bQ445eeC+uDx6CVlAQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nICJy-00H7Uq-KD;
        Thu, 10 Feb 2022 17:29:26 +0100
Message-ID: <d5342bc7cd749d1123b46dfd7ae0d2318c7e9f3f.camel@sipsolutions.net>
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
Date:   Thu, 10 Feb 2022 17:29:25 +0100
In-Reply-To: <DM8PR02MB7958662AC1065ED1D409AA90FE2F9@DM8PR02MB7958.namprd02.prod.outlook.com>
References: <1640163883-12696-1-git-send-email-quic_vjakkam@quicinc.com>
         <1640163883-12696-3-git-send-email-quic_vjakkam@quicinc.com>
         <DM8PR02MB795853BB4B1C71B20857D2D3FE2F9@DM8PR02MB7958.namprd02.prod.outlook.com>
         <793a595932ea0adf7a72eeafb6ababdae8e21fc2.camel@sipsolutions.net>
         <bdc46437131fc41a1e3217099ca9395ca3c63b41.camel@sipsolutions.net>
         <DM8PR02MB7958662AC1065ED1D409AA90FE2F9@DM8PR02MB7958.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2022-02-10 at 15:57 +0000, Aloka Dixit (QUIC) wrote:
> 
> 
> My comment was actually about your Patches but realized I hadn't
> subscribed this email with the mailing list so never got emails for
> those.

Oh.

> So replied here (as I am in cc), just pasted wrong link 😊

Ah ok :)

> 
> But yeah, union would work.

I'll also make all the pieces have the right size in nl80211.

johannes
