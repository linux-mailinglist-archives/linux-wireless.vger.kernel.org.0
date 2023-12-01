Return-Path: <linux-wireless+bounces-286-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B198008FE
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 11:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 059B4B214ED
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 10:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC97B208A9;
	Fri,  1 Dec 2023 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pMAoUiWr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AD310F9;
	Fri,  1 Dec 2023 02:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pbT5nVlbtaNJWk3OFp9TIwvQcdjuEvfIwGplFvit318=;
	t=1701427796; x=1702637396; b=pMAoUiWruuvQdziTHxdO+1Z1872yiUxSW0pv7sgaO1OQZJk
	dPiTL1R8XhXUWxtbIncaqjTlhrggCJEu9EtS/lwocvpzGenfMDAlXAV1lJSzxz868RV/5ITk78khG
	Ax3/u87LIzaF1bmN7yty6fsaKUnVdrFPN5vfAHSWuEro7wjJGp2JxsiGKUtJvCXzLyQc9IMNCQoUD
	ucyVxgs2ucyYh9JzzcloH02nx8d9kEPfhrqtVEHePz+2b2yg8+vF/Y88/UvLNeSvfZvZCX47XWMAG
	NeMfhQRVQSxsNA1oE62MmB7JKhfk4MBI8tR1Ex3gy5okdxuhWz0pzaS6v8KVAMXA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r915m-0000000BBjV-2QKF;
	Fri, 01 Dec 2023 11:49:54 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: hostap@lists.infradead.org,
	netdev@vger.kernel.org
Subject: [PATCH wpa_supplicant 0/2] wpa_supplicant: wait for carrier race
Date: Fri,  1 Dec 2023 11:49:07 +0100
Message-ID: <20231201104952.26254-4-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <346b21d87c69f817ea3c37caceb34f1f56255884.camel@sipsolutions.net>
References: <346b21d87c69f817ea3c37caceb34f1f56255884.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the userspace part, waiting for the carrier up count to reach
the value indicated in an event before processing it, so that after
the event processing we can be sure that everything is A-OK for TX.

johannes


