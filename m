Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660A7311F5A
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Feb 2021 19:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhBFSbH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 6 Feb 2021 13:31:07 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:57001 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230198AbhBFSbF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 6 Feb 2021 13:31:05 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 8D0ACD38;
        Sat,  6 Feb 2021 13:29:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 06 Feb 2021 13:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mm.st; h=date
        :from:to:cc:subject:message-id:mime-version:content-type; s=fm2;
         bh=fNUIWRwdRTvbOml+GBY56EEaQVSxPIbE7ClYrOr9Mm0=; b=cnMa9e2WsyZo
        TK1flXKcDfhO1aNBG8tgAgm6lj80Col1NsDFuhiTa+dcyZWDiWhTmXTo3Xoh6fxv
        CLIN8W/HaWI7kEHrpZx9Ebs+LyoGjr5asmsEl6OFR8lZGiCrJek6DnQ85ew+1oiV
        QkSGjupVciHKkh/6u2D85XeP2zlkTLkM9rzZKFV7qvCG+RneSopf2pKosWCf5OAS
        N72urNH/Exw00MDb7rbWkjIu5KZdUuOTdIuliL2pzEuJ9lPnjLJ71r+vZ+He59Yi
        i6QpeKkbA6vNU+1r3F6xGAJn8S2W7m4l/MHCFOqV3zGESJmv3fJqfhf0rH05sstN
        BSHKN3YHAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=fNUIWRwdRTvbOml+GBY56EEaQVSxP
        IbE7ClYrOr9Mm0=; b=DSee4LsW0RLX4ZN07ecMyRRI+vWxUJANCzU+suxuhc54J
        ePCdUS4ycor6NvLK2SzLRg/NPuHHwbdfCfR21IzhSH3AKLx1rt9+M985v0cqNEec
        Gae8rwyXPXKH5/R80HAE4bpHCoE85B3nGeUxcDzuX0X2D3kY0Uu1bbvIsrc6apWu
        SApaM9eSRmU/rzYRWsGhbt7mDpJrGYQ9EGOLzoVIr97dpm98lOCdlmM4qyY2mO0/
        K4ypa/Vn6PSam9q7Hv1S1CRui1/0t0mnmT5yIhWTlOePMuvanz1fEDKsiHMfppPm
        26yVDdYyzedryFpPXg/NY+OFivoj5TAURd5HMqmlg==
X-ME-Sender: <xms:JuAeYEteG1YARpihSLBjCn44OteZrBXDn3QtuIuTZ9ntN9xzyVhpzA>
    <xme:JuAeYBekeH-yP7Of8mhyCUIeCEJv2lhyj5F02zRcx3NweeP8oIX3JdYu383nQRv8i
    CrL0YC84tggqIbNTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrgeekgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesthdtredttd
    dtjeenucfhrhhomhepgghsvghvohhlohguucfmohiilhhovhcuoeiirggsrgesmhhmrdhs
    theqnecuggftrfgrthhtvghrnhepudekfeevgeejveetjeetvdeivdekheektdfgtddvgf
    efhfdukefhtefgueduudeunecukfhppeekjedrledvrddutddrvddtkeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiirggsrgesmhhmrdhsth
X-ME-Proxy: <xmx:JuAeYPzfXtj7uki2qhpnwAvxXo1fn7uBDwpyJbIWeyI6Yt_2U2yD3Q>
    <xmx:JuAeYHMy1aah7cG8AGlJPS5_3OkDCNXhWSdTJcfjKhuci2CirmMWkA>
    <xmx:JuAeYE-RYQwpOC4foQ8Iwrta4hy_SH4LraK-lQgvHsjcY67hKz6z1g>
    <xmx:J-AeYCn5xr4pWZuCnN50a9ZhC8RrhI5SOJ4zugFsC1K8KZIF_qqKlw>
Received: from Vsevolods-Mini.lan (87-92-10-208.bb.dnainternet.fi [87.92.10.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1651D24005A;
        Sat,  6 Feb 2021 13:29:57 -0500 (EST)
Date:   Sat, 6 Feb 2021 20:29:55 +0200
From:   Vsevolod Kozlov <zaba@mm.st>
To:     ajay.kathat@microchip.com, claudiu.beznea@microchip.com,
        kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] wilc1000: Fix use of void pointer as a wrong struct type
Message-ID: <YB7gI+c1X633KOde@Vsevolods-Mini.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ac_classify() expects a struct sk_buff* as its second argument, which is
a member of struct tx_complete_data. priv happens to be a pointer to
struct tx_complete_data, so passing it directly to ac_classify() leads
to wrong behaviour and occasional panics.

Signed-off-by: Vsevolod Kozlov <zaba@mm.st>
---
 drivers/net/wireless/microchip/wilc1000/wlan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index c12f27be9f79..04ed52c736ff 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -415,6 +415,7 @@ int wilc_wlan_txq_add_net_pkt(struct net_device *dev, void *priv, u8 *buffer,
 	struct txq_entry_t *tqe;
 	struct wilc_vif *vif = netdev_priv(dev);
 	struct wilc *wilc;
+	struct tx_complete_data *tx_data = priv;
 	u8 q_num;
 
 	wilc = vif->wilc;
@@ -437,7 +438,7 @@ int wilc_wlan_txq_add_net_pkt(struct net_device *dev, void *priv, u8 *buffer,
 	tqe->priv = priv;
 	tqe->vif = vif;
 
-	q_num = ac_classify(wilc, priv);
+	q_num = ac_classify(wilc, tx_data->skb);
 	tqe->q_num = q_num;
 	if (ac_change(wilc, &q_num)) {
 		tx_complete_fn(priv, 0);
-- 
2.20.1

