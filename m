Return-Path: <linux-wireless+bounces-14634-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2F29B4A61
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 14:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188E71C225A2
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 13:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197B95227;
	Tue, 29 Oct 2024 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAuo5KN9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE847E567;
	Tue, 29 Oct 2024 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206813; cv=none; b=MuAqH3cPEJULNqRSleidEC52vHbEuPjWI4hHitT2AiMCotcGl9PofowkiRbKOCMLJykIxZ+Lf+Kq0QLJWtpXy5hHo2ecdj1Kt19WEHzwYicgb+cu9k/vWKL7RyLhBgsHr9uGdiatg8c963SadVh9uCYlA4yGFAWLbJsG1PVTxUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206813; c=relaxed/simple;
	bh=zGvK4DqArbuXHNXdndSqdwG9as46n/2O9IwxX+rJkLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZMXjHTlTAUB6qwo8Q/atJdK793hxkNr6aBXOsqfXDl+2GgAeRu3vJ6wwoW1LME65gvI5y9b2Ygxfo0sYOkX/s7ms7aayOOIk189iGoRV3gEDnuJmM4HpiMRBtI0f1HEMbQo9hxQmqUsbvBm47JBVlhFlcRwhVbNA1/reW7EQfx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAuo5KN9; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539fe76e802so6456204e87.1;
        Tue, 29 Oct 2024 06:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730206808; x=1730811608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=thYeJL4yzQqwIknQzMwxVzj4gFmKpuzE/lybvJ1nm9c=;
        b=gAuo5KN9cYFNYtTSYW8HL13WtqNQYIuIUq/RgigIJxYSfVA2M/Ffdoo3I9qu5J+xqW
         BYC47jNrVxbu+N0idb+0+umjRKPIWb6voWXxfVI+6K2E5QkDpsCt1OH5m4pMTwDSffRC
         feGPvPO3mnLfWEcuPf03Y7T4/phDKxm1Je7XXkIO6J/FLAKw3gpUY1A549dcHhCFnARs
         lXFyETAqONhX92+y2sdB2mRmiMAEXIHYKAC7LNBmyY32Ib1zoW74NJmZoPigXhQ/TGbP
         Ws/GZASlf15ea5VX5Tib8bP4db50NDgLveVnMvCxwPtBjuS6GPx4seOZ0ffcBiSw5I1e
         VyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730206809; x=1730811609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=thYeJL4yzQqwIknQzMwxVzj4gFmKpuzE/lybvJ1nm9c=;
        b=r0CNJhmMJkdd2MeKTV3SVC9X+2s3P9MjTuF8BHGgyPP+sKZU3o5DVEE68tHKhHXOpd
         u+ES1raMwqNfRhBshGCha/Y8ZenEE54bZ6bPIo3gxmF4TqjpW5fU+SyyHq3f1Rbc5sdI
         XL75NccjStOA84e8dGYXFNiI8COwqrc4/nJF/FrqPo2HVpl4lyZWlzk2p3IQDb+c2b5B
         OOgM/WHBxAiMFGHTTTLTct4RxIz/MRxleyunOdnwZmrhhraB4uQhO3O4fZ7Yt1oMVlfx
         37rBot/yr8TN6E77bOij74foQznjvj1eIwCzXzOqr+ZSd86sXTFCHny3oAUD+k8EvpFT
         Ntkw==
X-Forwarded-Encrypted: i=1; AJvYcCU9FBXsnIlwzh1Jaj8sTMcXDVZKQ6FwZcJ9NLCFQefZbuS2gW8VZKnEzHqS9bJ/xPeuQEytQoI/AoTPM08OVbI=@vger.kernel.org, AJvYcCVItmOnpc7AdY/Rbl3Zp6NMrpctHpgC8ef9WbKoWSXSmAmm0Zsw20/OF51ITqbWFV1/kXCUrAqVlNADPr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4nGeBlPLzRlEuQtRNzkH3U/zosXT9wMBZEs7hU8dco9P+ZchL
	85HEC/yDKgvmVJkYKW5OA9NwrdXj8kClkwXw9sApVXJJMtNLZ2c5NI2klcgG500=
X-Google-Smtp-Source: AGHT+IHctOb0nDG34kRvXL8VPLc9QtHTlKvczF+pAJqcInnZNwC0+Wq1zk9q6fUMJnDSnpUsFfYKpw==
X-Received: by 2002:a05:6512:32c7:b0:536:a50a:3c25 with SMTP id 2adb3069b0e04-53b348c1612mr6073864e87.12.1730206808250;
        Tue, 29 Oct 2024 06:00:08 -0700 (PDT)
Received: from localhost.localdomain ([178.219.169.18])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b48999d30sm214911e87.115.2024.10.29.06.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 06:00:07 -0700 (PDT)
From: Dmitry Kandybka <d.kandybka@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Kandybka <d.kandybka@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10/5.15/6.1 0/1] wifi: ath10k: Check return value of ath10k_get_arvif() in ath10k_wmi_event_tdls_peer()
Date: Tue, 29 Oct 2024 15:59:24 +0300
Message-ID: <20241029125929.288059-1-d.kandybka@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SVACE reports a potential NULL pointer dereference in 5.10, 5.15 and 6.1
stable releases since the commit 4c9f8d114660 ("ath10k:  enable TDLS
peer inactivity detection") that caused this report was appeared.

The problem has been fixed by the following upstream patch that was adapted
to 5.10, 5.15 and 6.1. All of the changes made to the patch in order to adapt it
are described at the end of commit message.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Peter Kosyh (1):
  wifi: ath10k: Check return value of ath10k_get_arvif() in ath10k_wmi_event_tdls_peer()

 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.43.5

