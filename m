Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C14B4B2D42
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 20:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240877AbiBKTDL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 14:03:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239867AbiBKTDK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 14:03:10 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B8ACC8
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 11:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=HUU4MVqatlNHeCve5f+JE74d/yHY1XgLy1dgwj6s/CA=;
        t=1644606188; x=1645815788; b=DJM0BZrpsGk9FXZPH/rJABcpEt2DWbv2+kw9776pL9AJvc5
        91qVGjqHMCWhUvCoJBpBVXGXhVyEjcEaAbmwJWRDfSvlwjvWOsJxlOCSWwhcxATCju5lycDr0sByY
        L9XOeE8sQtr9RnZa1L+ztJbdUC2u/IXzbIwJ6FKnwEu2RJi+nfPcxRf/dH4Wf35gm+yQ8V9gCrKOT
        jjl+2m6vt1yr1QBKDXuhGcJ6X5M/r2dHC6B9CiOrLma12GRxDknrglub7QFavoNOFJSE7AVFUkuU9
        7vuJfNsV1ptGr9mIHmf3vNcvYUTgfE6FiEon8DlcCv/zU6idNtZK6TBeSSfiGMRw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nIbCD-00HadR-74;
        Fri, 11 Feb 2022 20:03:05 +0100
Message-ID: <13d897bae6ac5bfd25c7b2e2c80fdaac392334ce.camel@sipsolutions.net>
Subject: Re: [PATCH v2 06/19] cfg80211: Add data structures to capture EHT
 capabilities
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Aloka Dixit (QUIC)" <quic_alokad@quicinc.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     "Vikram Kandukuri (QUIC)" <quic_vikram@quicinc.com>,
        "Jia Ding (QUIC)" <quic_jiad@quicinc.com>,
        "Karthikeyan Periyasamy (QUIC)" <quic_periyasa@quicinc.com>,
        "Muna Sinada (QUIC)" <quic_msinada@quicinc.com>,
        "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        "ilan.peer@intel.com" <ilan.peer@intel.com>
Date:   Fri, 11 Feb 2022 20:03:04 +0100
In-Reply-To: <DM8PR02MB7958C66988E52F40F0ED8A6AFE309@DM8PR02MB7958.namprd02.prod.outlook.com>
References: <20220210192008.188166-1-johannes@sipsolutions.net>
         <20220210201853.c40044dc90e9.I2413a37c8f7d2d6d638038a3d95360a3fce0114d@changeid>
         <DM8PR02MB7958C66988E52F40F0ED8A6AFE309@DM8PR02MB7958.namprd02.prod.outlook.com>
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

Hi,

(something weird happened with your quoting?)

> An instance of struct ieee80211_eht_cap_elem should be added in struct
> cfg80211_ap_settings (same goes for operation element) as well and
> parsing in nl80211_calculate_ap_params().

AP mode, especially non-mac80211, wasn't really high on our list ...

I'm also not sure it really belongs to this patch, since this patch was
just meant to capture the EHT capabilities of the device, not support AP
mode :-)

I think I'd prefer to have a separate patch, later, and we can discuss
whether I should submit that or you want to (I cannot really test it).
Any objections?

This is already 19 patches anyway, plus a few other prerequisites I sent
separately, so I think in the interest of getting anything done ...

I know we also don't connect with 320 MHz yet (the EHT operation element
is also not really well defined in the spec so far, we just have a bit
of a stub definition for it), and other things are for sure missing.

Any objections to doing things step by step?

johannes

