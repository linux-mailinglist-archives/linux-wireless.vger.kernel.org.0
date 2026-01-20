Return-Path: <linux-wireless+bounces-30993-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 84003D3BF32
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 07:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5A1A359E65
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 06:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7555436E49E;
	Tue, 20 Jan 2026 06:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfBVCy6B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F7036C5B8
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 06:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890541; cv=none; b=u78wzbEVIs1YGereQmAPF+FkKZtUPZ2nhDC+n1XXTHu23d2J+cyWUcpVnQq1O6zdZNiQorb6QbbYIke4I7FsXfglzeJs8IQ0ssPdexWrchW4f9+zmYwkS4qn9nhxJuG97NDfI6jSjf+c3kkF552giID6NF5XC7pLS+ASLMR3+Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890541; c=relaxed/simple;
	bh=2+HHCsL4CHpvAxtcpZ+oNfJ91XAAY5ApArx/L+V3+Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhTnYEmEWV8DsPzAK9nb8wlpoCL9oVRoSrgnqjmNwcsswcOiDB/2qPS/YqOFSoYM2UYGdLflu0dCNPyr7hprhUwqrmVeWzXF2Dhx+4X8UV+O8+AWkng9WP4NFNH/mo3nJVcgfw1j55rvQUt3Oth9LbWOyg4Fp7Pqt7sFbwr//Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfBVCy6B; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ac3d5ab81bso5272037eec.1
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 22:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768890538; x=1769495338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZqhvQUqHyPjd5YwFiryR+es7m9UdWSAqM9hdcVMAYY=;
        b=KfBVCy6Btat3on8k4RWjWohTf/kL/A3GiZd/jR1dWPTZ7i8oymlmP7SNvzFIyhz0XK
         8nA5MBTVR2ZmcixOvOKqha7hwOgVfpEE4xClNZ9FbNCVyLLP1aa5qOCRci/93z/xAJ7y
         gGlVLb1IqjLb5qLobEpBugeiuNlaRdhzhF6g8sf8BY8uIZ7EuHNjUJsaWkjYu/EZCp7b
         ip0bDp+gWeLFxjsiP/2+eaSJkuHG8NRqay56tqxJeJ6D24Zf8zmryBhuoUKZjByAH3Hd
         zxBSCdt4hcC3HfQkao6ggL4hhq4z1UHu3RdOUQ5VVwsO6Wfat6XaFhuwUCErshY199Q/
         x32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890538; x=1769495338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hZqhvQUqHyPjd5YwFiryR+es7m9UdWSAqM9hdcVMAYY=;
        b=RdyjsH0jkhCgqvMxqb0KaX+o9BjrCqlN7YvOyXDKYMpCMCAuYGdtFO3/5Y5ahLUPEy
         Q0piC7a+vAnyQphBWni58l6l6sS4xL1IeTtTA5RB3hQrj5cJvzimafeM5OpGbYftwhXt
         j2eG79ePAu9TAwAfgLIxCkrNpZBlnS7JLfk/YR9U2UEwbCLp0EegC6qDqx9VPIgW9E4W
         MmuFTHShWKHj1tJX72ygNb/vha8GemOslEpzwYzZ1s/ncUWM9FWzwNGt+jYcbySKhLSO
         FJLzyPjdZs2KTJZ9+b94c2izjHax32OtPXgIGTP6ZxX/CryPwVShtyDhZ0o7sWlOAiiF
         4uVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuWCQb2aHjX0WcT2hirbU6vDjzbKlms4P/peNDeN7BThq7NkLtXqICemnylxD0zj7NWFPtnIZPJ5ZGjzWt0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYR6/mlJ8kgIe2ZAmztXewhSBki8+uR8eWKiirs7mLCVryL/c4
	dNsizk50IJDzd9//ejokAMZDykRO5EZmes0hckRdHV+d8sSZd7bMZWO0
X-Gm-Gg: AZuq6aKoXxKr2xG7OTO5nt78zdFatbFAbShXjs9zRb4Atz6YuVm6ZmnDPMQcqTgYE9A
	+tB1Zmz53tK2AKSDk2DTg025Dpqj3vAvHfirtwK1MG24JNVK0uWYHEiaImaGly1f5BC6tcF9aTo
	eVXWkqi++ZpOIQCzaoH56el+z4usj28ytU7zdLX/wKAzOpTJqEFT31Gymz9jvhgiziA6+T0hGJB
	QVmXVzTXgilxOlYyXZbWlrNjaEC3Ls+bGDSNEug7RDn79vlHKaop7go7vDebiOJ6uD3NG/XwXu3
	iVMao9mImnGPH2pRJ1zoHPp/9vnU3i8iWeVmWD3rFZhmWQfAi9RkpuR3oZP4CK8Hs+HhSMb2Hqj
	dQY7PKtEe2wEjRbr+21eKHSe8m8MRIZjP2SKyhAg3CagSLtdm5NQQVTAf+8KWfZj5jpMakaN/1x
	q1/sAfDRK83BJI3mm2ktHNTGheKgZU48rQVCVsEgpGK7m7CeRAallNyVe4UDc472LFupHyKRs=
X-Received: by 2002:a05:7300:6420:b0:2ac:1c5a:9950 with SMTP id 5a478bee46e88-2b6b4e98df3mr12535391eec.34.1768890538000;
        Mon, 19 Jan 2026 22:28:58 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f31e:1cb:296a:cc2a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm15706784eec.9.2026.01.19.22.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:28:57 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: sean.wang@kernel.org
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	stable@vger.kernel.org,
	linux@frame.work,
	zbowling@gmail.com,
	Zac Bowling <zac@zacbowling.com>
Subject: [PATCH 01/11] wifi: mt76: fix list corruption in mt76_wcid_cleanup
Date: Mon, 19 Jan 2026 22:28:44 -0800
Message-ID: <20260120062854.126501-2-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120062854.126501-1-zac@zacbowling.com>
References: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
 <20260120062854.126501-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zac@zacbowling.com>

mt76_wcid_cleanup() was not removing wcid entries from sta_poll_list
before mt76_reset_device() reinitializes the master list. This leaves
stale pointers in wcid->poll_list, causing list corruption when
mt76_wcid_add_poll() later checks list_empty() and tries to add the
entry back.

The fix adds proper cleanup of poll_list in mt76_wcid_cleanup(),
matching how tx_list is already handled. This is similar to what
mt7996_mac_sta_deinit_link() already does correctly.

Fixes list corruption warnings like:
  list_add corruption. prev->next should be next (ffffffff...)

Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 75772979f438..d0c522909e98 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1716,6 +1716,16 @@ void mt76_wcid_cleanup(struct mt76_dev *dev, struct mt76_wcid *wcid)
 
 	idr_destroy(&wcid->pktid);
 
+	/* Remove from sta_poll_list to prevent list corruption after reset.
+	 * Without this, mt76_reset_device() reinitializes sta_poll_list but
+	 * leaves wcid->poll_list with stale pointers, causing list corruption
+	 * when mt76_wcid_add_poll() checks list_empty().
+	 */
+	spin_lock_bh(&dev->sta_poll_lock);
+	if (!list_empty(&wcid->poll_list))
+		list_del_init(&wcid->poll_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
+
 	spin_lock_bh(&phy->tx_lock);
 
 	if (!list_empty(&wcid->tx_list))
-- 
2.52.0


