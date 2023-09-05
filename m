Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067CE792519
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Sep 2023 18:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbjIEQBY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Sep 2023 12:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354675AbjIEN1x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Sep 2023 09:27:53 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA8712A
        for <linux-wireless@vger.kernel.org>; Tue,  5 Sep 2023 06:27:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 96B71CE1187
        for <linux-wireless@vger.kernel.org>; Tue,  5 Sep 2023 13:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D088DC433C9;
        Tue,  5 Sep 2023 13:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693920466;
        bh=pnk4sCutSBEzjsIxmj9YusKcT1QMT0+L2O9Zh5dmwfc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=dyq65rDsVSFKcwIZ+wwrS/9SXVflJNfMjjsxuefUX61FJn7k5Wtdook9ZMubPEcCK
         3V87rB6M8woLLCiOzu2jN/kd7QBOGlOqORUGLXzzy3DgkB1v+CWiWYgz2vQdF+kk5W
         fLjy/iHOax1N2L7k628/LsDu0HYnEUkzf1ORRVZDz7HI6cZ4+3x4WgDzgcGDRyg4Dn
         TmMjS2x0YUfr2AikADPdShR2TsEgA1WSM/2YhuEQfakAiKzeEd8Ivpxanq+eD4MmI3
         G1GtfcSUbD2AgjqRpJugW764S3Z/JD42BXUsoslTXruF6BeZbISaXo/4MRXCoXhxFx
         m0COjz0dkeQgw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath11k: move references from rsvd2 to info
 fields
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1692827868-15667-1-git-send-email-quic_msinada@quicinc.com>
References: <1692827868-15667-1-git-send-email-quic_msinada@quicinc.com>
To:     Muna Sinada <quic_msinada@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Muna Sinada <quic_msinada@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169392046359.3610046.160119621515674643.kvalo@kernel.org>
Date:   Tue,  5 Sep 2023 13:27:45 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Muna Sinada <quic_msinada@quicinc.com> wrote:

> Remove references to reserved fields and add new info fields for
> struct hal_rx_ppdu_end_user_stats. Reserved fields should not be
> accessed, therefore existing references to it are to be changed to
> referencing specific info fields.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00356-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

5bd2ced044bb wifi: ath11k: move references from rsvd2 to info fields
7791487cd16c wifi: ath11k: fix tid bitmap is 0 in peer rx mu stats

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1692827868-15667-1-git-send-email-quic_msinada@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

