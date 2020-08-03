Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF2823A973
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 17:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgHCPdu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Aug 2020 11:33:50 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:51542 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgHCPdu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Aug 2020 11:33:50 -0400
Received: from legolas.tu-ilmenau.de (unknown [141.24.111.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 921D7580060;
        Mon,  3 Aug 2020 17:33:47 +0200 (CEST)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 3/4] iw: handle all mesh config parameters
Date:   Mon,  3 Aug 2020 17:33:35 +0200
Message-Id: <20200803153336.319773-3-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803153336.319773-1-markus.theil@tu-ilmenau.de>
References: <20200803153336.319773-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 mesh.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mesh.c b/mesh.c
index 0650d0c..23b3471 100644
--- a/mesh.c
+++ b/mesh.c
@@ -264,6 +264,12 @@ static const struct mesh_param_descr _mesh_param_descrs[] =
 	_my_nla_put_u16, _parse_u16, _print_u16_in_TUs},
 	{"mesh_plink_timeout", NL80211_MESHCONF_PLINK_TIMEOUT,
 	_my_nla_put_u32, _parse_u32, _print_u32_in_seconds},
+	{"mesh_connected_to_gate", NL80211_MESHCONF_CONNECTED_TO_GATE,
+	_my_nla_put_u8, _parse_u8_as_bool, _print_u8},
+	{"mesh_nolearn", NL80211_MESHCONF_NOLEARN,
+	_my_nla_put_u8, _parse_u8_as_bool, _print_u8},
+	{"mesh_connected_to_as", NL80211_MESHCONF_CONNECTED_TO_AS,
+	_my_nla_put_u8, _parse_u8_as_bool, _print_u8},
 };
 
 static void print_all_mesh_param_descr(void)
-- 
2.28.0

