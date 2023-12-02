Return-Path: <linux-wireless+bounces-334-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B78801EA9
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Dec 2023 22:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D463C1F20FE6
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Dec 2023 21:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360112136E;
	Sat,  2 Dec 2023 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A0njk1uE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D83E102
	for <linux-wireless@vger.kernel.org>; Sat,  2 Dec 2023 13:27:56 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2867ace9967so458272a91.1
        for <linux-wireless@vger.kernel.org>; Sat, 02 Dec 2023 13:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701552475; x=1702157275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HHEDt6VQ8LzeSpO7og1P0K/YDfArH7UZrlszyK0VJhs=;
        b=A0njk1uEzGdzfnskQb3vd7n5zV+OMsAAU/SYawClffVNIyX9gTme3Siqve1BeDAWGD
         XQRZBRiF4zHaGlySDgqNsCAuV1BeKhiVqzMZvmn7xOYJuLS+EY+ctFOcrRZV7CDaen1H
         CXcBtPkiyA7tK1iVhlFDSvOe1rxyuTxnxWcRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701552475; x=1702157275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHEDt6VQ8LzeSpO7og1P0K/YDfArH7UZrlszyK0VJhs=;
        b=MlopT1N6oMIZr5/dCc2LQoby5sWzucx5KTQrqC+3KVcDafSSA/HxaVbS2TqvhSxzPL
         FDbgONjkI77OPvjHrFclSzetjGDihl2Z1m07s8EOQ6Hzfnzi3vzw67imvy6IO1gFa6od
         ugN9TS2hBxKly9vsSBEcCTlQ7PsJMiTZNQ5dOWxUZ36WysGCFiJUTmGcq8jwREuyHb9K
         /Thza3LyW6cX03SLc88IiaLnEcJZt9xP9S8j/8FuRcZobrAkYFJrBRyp3YphIdmHnpL3
         Atuxua2gB5hoXjGRV8+Elx9o//seFU04NpgTBMJvhIPhQ3xtXqXY3tmiA9/vBKLzKRti
         yoJw==
X-Gm-Message-State: AOJu0YwNPd0Zln+AvgV1leo/8dLTkx9sGnMWejlCX53QTPrOJJXbQhqi
	ZjulqxGc0AOvsTaBz+PZVUksHg==
X-Google-Smtp-Source: AGHT+IFXUE4tSK9GGzbHw7vo/cKKLHlnC44NDlmDCgLl/yvcuTLoq9/NPk2WjmKD8tGBeTcLq2UwmA==
X-Received: by 2002:a17:902:bd05:b0:1d0:6ffd:e2e3 with SMTP id p5-20020a170902bd0500b001d06ffde2e3mr1629422pls.125.1701552475636;
        Sat, 02 Dec 2023 13:27:55 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i9-20020a170902c94900b001cffe1e7374sm5608964pla.214.2023.12.02.13.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 13:27:54 -0800 (PST)
Date: Sat, 2 Dec 2023 13:27:54 -0800
From: Kees Cook <keescook@chromium.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: mt76: mt7996: Use DECLARE_FLEX_ARRAY() and
 fix -Warray-bounds warnings
Message-ID: <202312021326.D3504C1@keescook>
References: <ZVaCNAohuieMmdq9@work>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVaCNAohuieMmdq9@work>

On Thu, Nov 16, 2023 at 02:57:24PM -0600, Gustavo A. R. Silva wrote:
> Transform zero-length arrays `adm_stat` and `msdu_cnt` into proper
> flexible-array members in anonymous union in `struct
> mt7996_mcu_all_sta_info_event` via the DECLARE_FLEX_ARRAY()
> helper; and fix multiple -Warray-bounds warnings:
> 
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:483:61: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:490:58: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:492:58: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:469:61: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:477:66: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:479:66: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> 
> This results in no differences in binary output, helps with the ongoing
> efforts to globally enable -Warray-bounds.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

*thread ping*

Can wireless folks please pick this patch up?

-Kees

> ---
>  drivers/net/wireless/mediatek/mt76/mt7996/mcu.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
> index a88f6af323da..9f516f796d63 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
> @@ -163,19 +163,19 @@ struct mt7996_mcu_all_sta_info_event {
>  	u8 rsv3[2];
>  
>  	union {
> -		struct {
> +		DECLARE_FLEX_ARRAY(struct {
>  			__le16 wlan_idx;
>  			u8 rsv[2];
>  			__le32 tx_bytes[IEEE80211_NUM_ACS];
>  			__le32 rx_bytes[IEEE80211_NUM_ACS];
> -		} adm_stat[0];
> +		}, adm_stat);
>  
> -		struct {
> +		DECLARE_FLEX_ARRAY(struct {
>  			__le16 wlan_idx;
>  			u8 rsv[2];
>  			__le32 tx_msdu_cnt;
>  			__le32 rx_msdu_cnt;
> -		} msdu_cnt[0];
> +		}, msdu_cnt);
>  	};
>  } __packed;
>  
> -- 
> 2.34.1
> 

-- 
Kees Cook

