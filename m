Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4C94EEC8B
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 13:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345575AbiDALuu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 07:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345604AbiDALut (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 07:50:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C82A1C232C
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 04:48:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2AADB823FB
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 11:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48976C340F2;
        Fri,  1 Apr 2022 11:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648813736;
        bh=ZQ34mNZDlm680HNHLxvtrq81EGouRSP61ne+1qa652Q=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=IFYM3c6KJSshmltsCdZIbuhVs70YmN/qb0A34HegdcEQEUBAUosMHOynZzdSC2QwI
         pYHOvJxm27ve2qWPuq3F7Cthl58Dvv7W1GFiVSAO3jebchedAcGIBTxCFOFfuvCOHY
         +4YBzFSO7miPrL5Nnnqy99Fqh6Dcs8AwpHuudmjTvMlK58OMVMSWGGv0WJD8Qq7r3r
         TMRMnNJ4ZWsJf27nx7cGz9fRoarqAs/P1l/Jjpwic6xSp0Uq9/DkAPPtqWqMekU9lE
         P3STX2zEXdRIo+I8boZrkM/MklEmBpLjqQHMpiZBI6URnIRKgwYSE+3gE34tROc6Zv
         fUiztVIX6z9Tw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ath9k: make is2ghz consistent in ar9003_eeprom
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220326054754.27812-1-wlooi@ucalgary.ca>
References: <20220326054754.27812-1-wlooi@ucalgary.ca>
To:     Wenli Looi <wlooi@ucalgary.ca>
Cc:     =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com,
        Wenli Looi <wlooi@ucalgary.ca>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164881373303.6665.531380382424724861.kvalo@kernel.org>
Date:   Fri,  1 Apr 2022 11:48:55 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wenli Looi <wlooi@ucalgary.ca> wrote:

> Replace a "mode" variable indicating "is 5ghz" with an "is2ghz" variable
> to make it consistent with other functions in the file.
> 
> Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

7c4582306412 ath9k: make is2ghz consistent in ar9003_eeprom

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220326054754.27812-1-wlooi@ucalgary.ca/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

