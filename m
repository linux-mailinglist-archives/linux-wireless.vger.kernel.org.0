Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945804B0C1A
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 12:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240728AbiBJLRL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 06:17:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240722AbiBJLRI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 06:17:08 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DBDFE5
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 03:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=D25bj31y0a/n8jRLLLVFFPPQadJDst9Lss6NCfSOze0=;
        t=1644491829; x=1645701429; b=Z1TIQlN0AVQ4E9vzyAV55MY7qgE0HbyMR7GmneRZujbv9bT
        nCpl6XqQZxRCT9sXeYqanOq/vOPkeQTegT8SpKPyzCWrU2wKc1T+5XMVoB2JicPaicZuHiBEZkbZD
        +dCpz8Y4durja1ICMFvDMQQOuiRoxyDzXJdi43EtWW+hAE5z0uFW+h3seh/TMRhKzg+GXglhmkPOA
        hKaJ/TB2o8f/7kWQuolHBP97QzwCKk1uuECuwxqp4XUAkorQ8MH/IZS1cze74cFdnmf0XEkzfjNSi
        mVccsC1PEU/2A31jPB3DFDf7fYtmQTOcvvwTuH70YdHNi0r3F9XoPpCGof8BtCEg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nI7Rj-00H1EO-5R;
        Thu, 10 Feb 2022 12:17:07 +0100
Message-ID: <bdc46437131fc41a1e3217099ca9395ca3c63b41.camel@sipsolutions.net>
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
Date:   Thu, 10 Feb 2022 12:17:06 +0100
In-Reply-To: <793a595932ea0adf7a72eeafb6ababdae8e21fc2.camel@sipsolutions.net>
References: <1640163883-12696-1-git-send-email-quic_vjakkam@quicinc.com>
         <1640163883-12696-3-git-send-email-quic_vjakkam@quicinc.com>
         <DM8PR02MB795853BB4B1C71B20857D2D3FE2F9@DM8PR02MB7958.namprd02.prod.outlook.com>
         <793a595932ea0adf7a72eeafb6ababdae8e21fc2.camel@sipsolutions.net>
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

On Thu, 2022-02-10 at 09:26 +0100, Johannes Berg wrote:
> > 
> > Considering that 20MHz-only STA and one that supports other bandwidths will not occur at the same time,
> > instead of a separate field for struct ieee80211_eht_mcs_nss_supp_20mhz_only inside struct ieee80211_eht_mcs_nss_supp, we can use a byte array as we added in here:
> > https://patchwork.kernel.org/project/linux-wireless/patch/1640163883-12696-3-git-send-email-quic_vjakkam@quicinc.com/
> > Instead of length field with dynamic allocation we can have an array of size 9 bytes.
> > 
> 
> We did something like that in our patches:
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/20220204230119.b0eeb527d761.I2413a37c8f7d2d6d638038a3d95360a3fce0114d@changeid/
> https://patchwork.kernel.org/project/linux-wireless/patch/20220204230119.1ee92202ac30.Id30a3ef2844b296efbd5486fe1da9ca36a95c5cf@changeid/
> 
> Not overlapping wastes like 4 bytes of memory, I think I can live with
> that, vs. the extra complexity? If you overlap you need another bit to
> indicate which one you're using ...
> 

OTOH, that means we need to unwrap it in userspace, which is also
strange ... So yeah I'm changing it to a union.

johannes
