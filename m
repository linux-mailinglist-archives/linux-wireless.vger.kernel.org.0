Return-Path: <linux-wireless+bounces-15085-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A3E9C0795
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 14:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A351F216F2
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 13:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9141EF0A2;
	Thu,  7 Nov 2024 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TwbCupFV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CEE1F4FA5
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986422; cv=none; b=dU1pYF++IC/aY83houdsdJlY7RgrliXhhI9+PDDLDxP/QkDHHdF5nslq1pmajrMvfFIpi2e5bYeyfK3SXaDNbFIOl+HhWLDApKjZkbqkFbGCnBTontGHZx10yyEl1JC176NBDFGlftG3NDXUY7PJ6G3Y/7DXGq68Ggp4eQQCQcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986422; c=relaxed/simple;
	bh=pXzzdAP812U7JcUzvhc9z1v3q/R9jowSfX4n47mTGjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NMKT2lsXxDqgQTtqrv56QyecvuSP/P5RvRDaHPA6vyiNt6RhYb/oSA0MddPcCScsJHVDbm+HlzlLRdCA56xfaNNiYdRBjrq808TgYBUqtxKD57gTZKS0AotIWi2RNdFMzHTtSxNhPNHPU8hHBhyy7aeIOFVbKM3r9VqLZgP70z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=TwbCupFV; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RLG7x9CcTtr4f1udDLlhxq6gGzQrPxUpumuIcDoU8IY=; b=TwbCupFVhTpGr+AYyK5KSQlhSu
	OJOg2UP6TJDbgHr/iSb/DDReD9NWQ+g0VtZQmG+x28Y8YlJ5y/Os9HGU30f0tAJcRD+DUuuKXwPkp
	gY8SgdKOKuFGD0GIzp+NFdiWa53TDHzEOpG2Mg1i/CPYX/A6w5Ix74BWZkJJOGplWIkFFUsMPrLgx
	iiWgB2vgz4Z2u78r+S4VkAxI7pPI3X/1Itrb/wu1vif9Q3bjNUtOg2sZCVwU/2Zd2IitC90Weypgu
	pSeuJEtyK69flYH0ZI2xXhGaoQSPHWN49OuUmT9O7VBU57YimLdMoGL1F1YpvVgRvaT+eqWYtHW+B
	2jKkd8YA==;
Received: from 179-125-64-253-dinamico.pombonet.net.br ([179.125.64.253] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t92di-003Zsz-Ta; Thu, 07 Nov 2024 14:33:35 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-wireless@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH net 0/5] wifi: rtlwifi: usb probe error path fixes
Date: Thu,  7 Nov 2024 10:33:17 -0300
Message-Id: <20241107133322.855112-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are fixes that affect mostly the usb probe error path. It fixes UAF
due to firmware loading touching freed memory by waiting for the load
completion before releasing that memory. It also fixes a couple of
identified memory leaks.

Thadeu Lima de Souza Cascardo (5):
  wifi: rtlwifi: do not complete firmware loading needlessly
  wifi: rtlwifi: rtl8192se: rise completion of firmware loading as last
    step
  wifi: rtlwifi: wait for firmware loading before releasing memory
  wifi: rtlwifi: fix init_sw_vars leak when probe fails
  wifi: rtlwifi: usb: fix workqueue leak when probe fails

 drivers/net/wireless/realtek/rtlwifi/pci.c          | 1 -
 drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c | 7 ++++---
 drivers/net/wireless/realtek/rtlwifi/usb.c          | 7 +++++--
 3 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.34.1


