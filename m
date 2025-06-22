Return-Path: <linux-wireless+bounces-24315-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91B0AE3119
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jun 2025 19:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ACF5169180
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jun 2025 17:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C6E15B0EF;
	Sun, 22 Jun 2025 17:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="EjglUTab"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118AB8634F;
	Sun, 22 Jun 2025 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750613297; cv=none; b=RR+gw0zp0MXme/mUFWWHDleaZxcea+UqmySzYXqvaoKXIATypv67SdDkkCkInvdIZTlX6bQ9Ipp0V2k/5EHGsM0QVjTJFLq/hqYz5pTyOhU5TlcBygcPClQJQ6EcbmL8fDandeIo1x/JAnCIvFp58AzAYB08+MYWyQPz5Qadf3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750613297; c=relaxed/simple;
	bh=zfZNFIJVuks1xMbjWKi1ypEiF4aVeVwnT029pgDpkAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rYjlTe9a2XzrEjO8tIj9P14HOVtaGdA+J3mtoPkX7GEQz+N+DM+NBvkGJbceyIrGkSLiwKVTAQOs2eWv5VgkoFpK1S8z+KGAFTrkhL/n294SXgm1DdVWvwlC4Y6ZdEpcWPRNUsSW2RwxHnawhxERh/8EUV36Uz3FeV/NAKV4VkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=EjglUTab; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=WAlmDJXWFVgdp9HXRRWx4cFG5VDgpskGL6la7+kHSf4=; b=EjglUTabp+jjMU5H
	vANBV3wf1IFiZHEjtlAHuHJLvDwfO4hVOuGbYNm4lFoOI0Uk9qatgPqb3swvVNGrfSULlOJHAjtSP
	71ov74ya+ylvKI9x7DoB0ahRZ81loeJSpoqmTt4bNSbSvOiLE4dXi0FjGaaQi/mbmc7soprH0rhTp
	DY4yABY2bT5ZLxjPTx0iRpqS8K5MxpnF4qsvFmOR+rJb63giCS0Owmrt0sg+4K7lT5jtIXnThAEhf
	uXFNeJ68HTBFokiWIJP3H5xvUh8res9Ov+grgFOTmLgnnuo9VtBuzONOESUb0kMsrGfhdDVpX8O+2
	Ma8ms3WwJGAJ50XSgA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1uTOUA-00B7p5-0k;
	Sun, 22 Jun 2025 17:28:06 +0000
From: linux@treblig.org
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/2] wl1251 deadcoding
Date: Sun, 22 Jun 2025 18:28:02 +0100
Message-ID: <20250622172804.116396-1-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  A couple of small deadcode patches for the wl1251;
they're pure function removal rather than
anything more subtle.
P
Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>


Dr. David Alan Gilbert (2):
  wl1251: Remove unused wl1251_acx_rate_policies
  wl1251: Remove unused wl1251_cmd_*

 drivers/net/wireless/ti/wl1251/acx.c | 35 ------------
 drivers/net/wireless/ti/wl1251/acx.h |  1 -
 drivers/net/wireless/ti/wl1251/cmd.c | 79 ----------------------------
 drivers/net/wireless/ti/wl1251/cmd.h |  3 --
 4 files changed, 118 deletions(-)

-- 
2.49.0


