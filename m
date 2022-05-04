Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A92519E29
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 13:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348359AbiEDLki (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 07:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241790AbiEDLkg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 07:40:36 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C93226ACD
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 04:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=2UiD/BhPhAKge80SQY4QdqVoxCC3aaIcNZC9uWHl7e0=;
        t=1651664221; x=1652873821; b=qRkDd9J+iMRO3iZNWIcy6P/Xxzlgt5tMsbvWCN5GE6jM7Ia
        JGEQw+iILpCocpqfouKHdDE3oY4NCTIKu4a4+0s8JsR3DgHeb6CREBSruWy4PFNmlopae2ciGT3Yl
        GH73UFm2e0DYfxBSr4Vea/8exr84vQiurrjXb/+lO/cvCvbtSe3FsmwMKu7W7jVGOn4SiWn5ASG3Q
        qdKpziyQXE60VPBRGVrsvl3e/c7DhxE95NC7SZxVfjIRlssbpNUCUGCLm0u9U2YHVTx2gccHU90q5
        LF+kPDD+MbhF+6ykOTAWLuBfvN/jEqXdSjcmkAJn1s4TanTG2AvbbWylJOWdxYLg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nmDJT-0021Dn-Qm;
        Wed, 04 May 2022 13:36:59 +0200
Message-ID: <b08dd641698c652839d76f31b4fd014f9835b630.camel@sipsolutions.net>
Subject: Re: [PATCH v2 3/3] mac80211: EHT operation element support in AP
 mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 04 May 2022 13:36:59 +0200
In-Reply-To: <20220323225443.13947-3-quic_alokad@quicinc.com>
References: <20220323225443.13947-1-quic_alokad@quicinc.com>
         <20220323225443.13947-3-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
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

On Wed, 2022-03-23 at 15:54 -0700, Aloka Dixit wrote:
> 
> +	struct {
> +		u8 chan_width;
> +		u8 ccfs;
> +		u8 present_bm;
> +	} eht_oper;
> 

I don't see how this patch makes any sense.

chan_width/ccfs is already configured as part of the chanctx.

And present_bm is useless on its own?

johannes
