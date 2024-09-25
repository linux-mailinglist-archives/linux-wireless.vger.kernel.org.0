Return-Path: <linux-wireless+bounces-13150-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5825898581E
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0272B1F21772
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 11:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDD717BEB9;
	Wed, 25 Sep 2024 11:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBpQpbmK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B7717BEAB;
	Wed, 25 Sep 2024 11:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264209; cv=none; b=aSakRhGUIFNHGTtvOxSwgnnhaNE5jK/JoivckKogcaxFNs6kw0cGSsFKYFSGv+zfMCmbrZ+gaFSnE0oKXlm4vq2EpFQ/zU7Oqt8NU09FSHORhzEknC/qHUVc24IqrY19zFv3L3KeB3++nl7VFZPGu+JTKo+UCf20KPK4DC+nIFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264209; c=relaxed/simple;
	bh=04L9H7rILcMMC3wyWIRI4MWyb1bdq6z06FXZZkEPWok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EgWzEBuOg+XjG8N+Y8wMyFjt+p5Hj2h2rGoa3eVr2EMr+HURbY+Gzw0n9VbCvwTTGMU94w98nWSjciPUjrOafjydNx0JfkYJ/PAaTQ5j8OK7q1ZLYF8u0IMaUxuPqQWamZzcDU8ADWib0nkp5pYXzld+COlYfSbhv5vnQgbnYMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBpQpbmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A3AC4CECD;
	Wed, 25 Sep 2024 11:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264209;
	bh=04L9H7rILcMMC3wyWIRI4MWyb1bdq6z06FXZZkEPWok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eBpQpbmKYZ0lJsQPoaMuhkuJx5X3tBOFXlCNsC7xohf0mdAej+ufsC2iWHyoIjVBP
	 YIriL2aOcH2LgwErWGN0jvho1CzO1IRvpoTIKBN9iv+PCVD5BOMhmWEX7QHi+94Afz
	 qhtpU7R6qayx2PhTgdquf+HxTEuVn4PryLy26XC7SmDdtJl0lnS6ypX4LZk3YL/TxK
	 4DlfbKmv8Fj7DVUSuqlpmHuId8HZuf2QN9jjJZaXrI5vgHhZ1uTBaaXQIgrECD/iKE
	 sUWqKbnihKcAUxpV4JcI7gB9iVHVzJok5s9JhKV+Jn2nlaIz96QS0Vcj2d9SNTbJOE
	 bgUg1e901QUvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	syzbot+98afa303be379af6cdb2@syzkaller.appspotmail.com,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	toke@toke.dk,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 004/244] wifi: ath9k_htc: Use __skb_set_length() for resetting urb before resubmit
Date: Wed, 25 Sep 2024 07:23:45 -0400
Message-ID: <20240925113641.1297102-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Toke Høiland-Jørgensen <toke@redhat.com>

[ Upstream commit 94745807f3ebd379f23865e6dab196f220664179 ]

Syzbot points out that skb_trim() has a sanity check on the existing length of
the skb, which can be uninitialised in some error paths. The intent here is
clearly just to reset the length to zero before resubmitting, so switch to
calling __skb_set_length(skb, 0) directly. In addition, __skb_set_length()
already contains a call to skb_reset_tail_pointer(), so remove the redundant
call.

The syzbot report came from ath9k_hif_usb_reg_in_cb(), but there's a similar
usage of skb_trim() in ath9k_hif_usb_rx_cb(), change both while we're at it.

Reported-by: syzbot+98afa303be379af6cdb2@syzkaller.appspotmail.com
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://patch.msgid.link/20240812142447.12328-1-toke@toke.dk
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/hif_usb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index 0c7841f952287..a3733c9b484e4 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -716,8 +716,7 @@ static void ath9k_hif_usb_rx_cb(struct urb *urb)
 	}
 
 resubmit:
-	skb_reset_tail_pointer(skb);
-	skb_trim(skb, 0);
+	__skb_set_length(skb, 0);
 
 	usb_anchor_urb(urb, &hif_dev->rx_submitted);
 	ret = usb_submit_urb(urb, GFP_ATOMIC);
@@ -754,8 +753,7 @@ static void ath9k_hif_usb_reg_in_cb(struct urb *urb)
 	case -ESHUTDOWN:
 		goto free_skb;
 	default:
-		skb_reset_tail_pointer(skb);
-		skb_trim(skb, 0);
+		__skb_set_length(skb, 0);
 
 		goto resubmit;
 	}
-- 
2.43.0


