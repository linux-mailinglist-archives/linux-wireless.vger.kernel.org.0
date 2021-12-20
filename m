Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B6E47B334
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 19:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbhLTSu0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 13:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbhLTSuZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 13:50:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9893C061574
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 10:50:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81BA0B8107B
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 18:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3205FC36AE2;
        Mon, 20 Dec 2021 18:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640026222;
        bh=dI1Rv6c882iBiID8Ttkir9wSeCGALV0cMqmtM67FLy4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=peFXY5fXcl5qgM3t+pOSWV0Sl1JiI7SHuntgdvSSVUgOPwBxvdfZAEY5eCCv5tT10
         blPBQWfYexeieiVFpOdzZbRa55P5xDJGAjTjpf1cS0wpOuRf6R+7kGjRsKqYBIqQFY
         1tXAI1v9SnSmfnH8Kq23MAPzJX+m3kwMx4yosq8hgkyj+A3R+go4Xs/FmFavlcFsxh
         hYN9f1XHkY0EBRXsx1+8+F2Xb515NF5xREJ9mDwLTrJs7aN+coWWVWzUCRJOa6gE62
         PkKY6BcC40Jo+nZcDYuo8ibSassjGxxOvX1TFyVM9UvqldlKptZkfyzrC6s8QA9k/L
         0sRC8a27KnSKw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: 8822c: update rx settings to prevent potential hw
 deadlock
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211217012708.8623-1-pkshih@realtek.com>
References: <20211217012708.8623-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>,
        <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164002621952.16553.4448199770717053538.kvalo@kernel.org>
Date:   Mon, 20 Dec 2021 18:50:21 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> These settings enables mac to detect and recover when rx fifo
> circuit deadlock occurs. Previous version missed this, so we fix it.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

c1afb26727d9 rtw88: 8822c: update rx settings to prevent potential hw deadlock

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211217012708.8623-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

