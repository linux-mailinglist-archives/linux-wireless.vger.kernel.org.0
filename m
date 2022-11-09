Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC335622467
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Nov 2022 08:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiKIHFw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Nov 2022 02:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKIHFv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Nov 2022 02:05:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BBB1DF00
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 23:05:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5482261783
        for <linux-wireless@vger.kernel.org>; Wed,  9 Nov 2022 07:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C707EC433D6;
        Wed,  9 Nov 2022 07:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667977549;
        bh=Pr7Nlg8rzM5DMQTnGQUaJ0OFZ8L5YL7zgieimDIg8Ac=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Z48EDSAhGIzO9GoFiVNVW3TcU7Q4DUPzzzYyzhKrS2aETzancleDdohim883xUFoI
         JohA8B+/tVz0cOhzzkKnHjuhUuvFoifan/tNijWb1zoYT/5WHvDdITqCXElngoglWW
         LqotSoiBI2qz9aFh+zjaB/tEQhY34oGOR39KVXcSTapxP9JLSon6gKvklkWekxdVdL
         cCg7Ly4ql7qYqzQHnJppYLiGV7Le53zB03dRP0/GWq0qErtUoHFrvi9eYDTJHWCep3
         fVo3MqdgJOhVwiU33XYS3/0v7x8qj6w89yNdOMvn6dU+sZJUYJz6oMZPtdIi0xWche
         fGTmTqEfVg0rw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath10k: Use macro for seq_ctrl conversion
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221106162227.1119-1-hujy652@gmail.com>
References: <20221106162227.1119-1-hujy652@gmail.com>
To:     Zhi-Jun You <hujy652@gmail.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Zhi-Jun You <hujy652@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166797754658.13342.14024033967389199102.kvalo@kernel.org>
Date:   Wed,  9 Nov 2022 07:05:48 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zhi-Jun You <hujy652@gmail.com> wrote:

> Use IEEE80211_SEQ_TO_SN() macro to convert seq_ctrl to sn for better
> readability.
> 
> Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

a60c04017298 wifi: ath10k: Use IEEE80211_SEQ_TO_SN() for seq_ctrl conversion

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221106162227.1119-1-hujy652@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

