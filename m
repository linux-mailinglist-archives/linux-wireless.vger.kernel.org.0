Return-Path: <linux-wireless+bounces-14253-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 482209A5FC6
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 11:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B4128441F
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 09:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29A51E285E;
	Mon, 21 Oct 2024 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="spCXKJ+p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49C71E284E
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502089; cv=none; b=PIHB7FJ1BkX0sgk+00+XPO/2Gj+neW4YM94BZughEPSPyZ32CYxTV1ANEv0sHgpgjvhqnhNUb5BRP632kS7Sn9UsAdr6QDcJs9d9pRt+4Ey2Vvpti1a15Oamh3vqL2NGdQvM92BfpIYYAeofwIhxyOKfzPmgffbmKl9IsriYsyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502089; c=relaxed/simple;
	bh=V5T+KifZpNxuES86cc0P0YZbHqO0QvYd0fJIuXHtqjI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tEkGat3tA7E4BXrmNyGKuqtat1KsfFpL3NAwDYUgmbWW0fhlG1E2IJGJKts9l2WbLnfxd2j3NauCW+d3BnExd+6FfwsyZCQdmq/9ZFAraLNAIQ1fua3uPUGQTAlnZSaTM1f8bGUNjzPlNmfDnvYITan+FaXnyMMtwPyEhwLN1WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=spCXKJ+p; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso33837995e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 02:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729502085; x=1730106885; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=viIdKZJdxzmzxa+AMbJaVQG5+tOcBpIZMwetXFmiAfI=;
        b=spCXKJ+pLh4Bcii+XX4iSHw3xQJbhEGmKC5zbtgSDy50JRAQZ+i0ERFJ+T0ZzCwJSu
         JnIyCpNZt/Gckso771wI816hJpuU8FRAl18TPWvEAuawNmnyd2DU/Jqzabi6acF2uvCe
         kJUHJPMHKX7KMN2Md5u087+HuVT1QaxWdbX6hcfNhAIAvqIlQ9ELzOPUri8h8/Wse6FP
         W90osZ2vioMrCF3J90MA6/GFKgp/2xdNdXn9ySMdT430nXRhmYPkM/EAyNXvxRTQ9yEU
         xwCOUtr+uZUjMNAnPtkvsSpox6Zz5IZAZDPD1wh5BS0qNSufJhAVj+BiJoz0M/ziNkJ5
         xtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729502085; x=1730106885;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=viIdKZJdxzmzxa+AMbJaVQG5+tOcBpIZMwetXFmiAfI=;
        b=v/qBsz5dPLAx9ujZVgeREW23L0XgDR2wvDnk4+dqMxV73z39ifa7RXhAGIhzBNH58S
         e9kjAApnICWhqUShc9U64JVz4ItkkkEgHufLCm2LHPD+GvILlce/2i/LNHnzXW37DrOn
         DcXZQ74ZoEXCeBY7Ys0lsTO53F9CG95lNVcwpzd9yy8r3vEvUQMAwjCxLknljU61ZClO
         SkInsvvHF7Rlmmui5gJdBv+4tVcKG2yNifkqXWIpmpCsECPG3gU5UCRmJEGn2UzMDgFQ
         B0rXRW+2gHiBxJI65FDZzE8Xu3Y3L1v0f/BHe07URCAysnTzRcsDgJz95lFfkp0vxoIp
         7UbA==
X-Forwarded-Encrypted: i=1; AJvYcCVoI8hTkgP5Xa8uvfahYF6Ytmn5hAjaqtGGgiQXNY1MJQhVHIHQXSzqNvOFARlBseqRyZLf7VQcezd1naWSqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Cx6jr8HoyubHegNA3r/14VrIWrE5DvoCEI29XQMuX9zhzzsU
	V9IFPNx9jLxCwQHSkYd7mygazY0I/h54EecaHPz14PdpUqEOvXuBCBoy2dm7Jrk=
X-Google-Smtp-Source: AGHT+IHRJ3XMQNNFSL+N9qTIsbeBkdqtT90O1Pz3aDqarzu2Bt0GMkFFH7O+TI0+CrOjEzrpheLyBA==
X-Received: by 2002:a05:600c:510f:b0:428:ec2a:8c94 with SMTP id 5b1f17b1804b1-43161631435mr80440425e9.10.1729502085149;
        Mon, 21 Oct 2024 02:14:45 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cb88csm50401685e9.39.2024.10.21.02.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:14:44 -0700 (PDT)
Date: Mon, 21 Oct 2024 12:14:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zong-Zhe Yang <kevin_yang@realtek.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] wifi: rtw89: unlock on error path in
 rtw89_ops_unassign_vif_chanctx()
Message-ID: <8683a712-ffc2-466b-8382-0b264719f8ef@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We need to call mutex_unlock() on this error path.

Fixes: aad0394e7a02 ("wifi: rtw89: tweak driver architecture for impending MLO support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/realtek/rtw89/mac80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 1ee63a85308f..565347a6e1e6 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -1373,6 +1373,7 @@ static void rtw89_ops_unassign_vif_chanctx(struct ieee80211_hw *hw,
 
 	rtwvif_link = rtwvif->links[link_conf->link_id];
 	if (unlikely(!rtwvif_link)) {
+		mutex_unlock(&rtwdev->mutex);
 		rtw89_err(rtwdev,
 			  "%s: rtwvif link (link_id %u) is not active\n",
 			  __func__, link_conf->link_id);
-- 
2.45.2


