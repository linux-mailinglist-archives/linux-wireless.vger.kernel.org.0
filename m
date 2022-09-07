Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E133E5AFDC6
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Sep 2022 09:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiIGHnh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Sep 2022 03:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiIGHnf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Sep 2022 03:43:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE179E2D5
        for <linux-wireless@vger.kernel.org>; Wed,  7 Sep 2022 00:43:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 421F9CE19FA
        for <linux-wireless@vger.kernel.org>; Wed,  7 Sep 2022 07:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E108C433D7;
        Wed,  7 Sep 2022 07:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662536605;
        bh=4qyxKVwpaEGj9NTGsKdpruZ4umxfn0QYMFxe7K1oHf4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=XgCB9kgV1buc7NUmXjndzBt/mZndtkuozzBmfAUmp+S0wUUc04dkzonopgm9mJkUr
         VaxuA9kCQlppqlqz4S+E/6AtT5Z5dsti2GwfBzu7VgXuHZg4FeLv1oJDXPn9HH2ohX
         C/a2Gj58LaQQe92ioDtJnIkFQ/xXDXpvSqntYQ0C7qu7mIIvaPUBNXc3ncGWZ+UBya
         UnpETlKgG1lu+8voFSxfAZ6jr/YN75giRSmx+Nj2WNNhdmWreaz/9S7ARh7WrCt2md
         iQ87xykYiYAEBVmuyAlcCI7RlcibpjMA6JqSav3QvvXBrd6Ykii+0XONOOi07S9Xj4
         zDt40QW20NOSw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 3/5] wifi: rtw89: configure TX path via H2C command
References: <20220902124422.13610-1-pkshih@realtek.com>
        <20220902124422.13610-4-pkshih@realtek.com>
Date:   Wed, 07 Sep 2022 10:43:22 +0300
In-Reply-To: <20220902124422.13610-4-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 2 Sep 2022 20:44:20 +0800")
Message-ID: <87czc7aaud.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> In order to support TX diversity, add a function to control TX path.
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

> +int rtw89_fw_h2c_txpath_cmac_tbl(struct rtw89_dev *rtwdev,
> +				 struct rtw89_sta *rtwsta)
> +{
> +	const struct rtw89_chip_info *chip = rtwdev->chip;
> +	struct sk_buff *skb;
> +
> +	if (chip->h2c_cctl_func_id != H2C_FUNC_MAC_CCTLINFO_UD)
> +		return 0;
> +
> +	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_CMC_TBL_LEN);
> +	if (!skb) {
> +		rtw89_err(rtwdev, "failed to alloc skb for fw dl\n");
> +		return -ENOMEM;
> +	}
> +	skb_put(skb, H2C_CMC_TBL_LEN);
> +	SET_CTRL_INFO_MACID(skb->data, rtwsta->mac_id);
> +	SET_CTRL_INFO_OPERATION(skb->data, 1);
> +
> +	__rtw89_fw_h2c_set_tx_path(rtwdev, skb);
> +
> +	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
> +			      H2C_CAT_MAC, H2C_CL_MAC_FR_EXCHG,
> +			      H2C_FUNC_MAC_CCTLINFO_UD, 0, 1,
> +			      H2C_CMC_TBL_LEN);
> +
> +	if (rtw89_h2c_tx(rtwdev, skb, false)) {
> +		rtw89_err(rtwdev, "failed to send h2c\n");
> +		goto fail;
> +	}

Please add a separate ret variable:

ret = rtw89_h2c_tx(rtwdev, skb, false);
if (ret) {
	rtw89_err(rtwdev, "failed to send h2c: %d\n", ret);
	goto fail;
}

> +
> +	return 0;
> +fail:
> +	dev_kfree_skb_any(skb);
> +
> +	return -EBUSY;

return ret;

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
