Return-Path: <linux-wireless+bounces-28294-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DAAC0C414
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 09:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392AA3A9B13
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 08:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58CB2E5B21;
	Mon, 27 Oct 2025 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hHikxe38"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E75D2E6CB3;
	Mon, 27 Oct 2025 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552704; cv=none; b=gvxt66CHIZoH8orjm+YAbNDRxTdyvXJjgijav/LuzQ++7q7YkCfXVXulOEe7TtJeg9AdlhGZKQ7wsEpBhGlRhQHtNkrHnFrHPcMulrn7GpH6eTrIze7On2IhuNnqAaKyVYH7lnQi4jBLVnAcRmTwHjXja1Ry2Kh+/P+DmrEIsDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552704; c=relaxed/simple;
	bh=s0c7nWYP4a8uTeRDD/AlFLRmr5kf20OBf9Y1FDUOwoU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uUxtTQD58Glgicw901meZ2HA90YXzP5RRw7/Nlnv0/NaAPikXzoAEL5cLOhir4krIj0xU3O7lT4bzkYRrcGVKZcpUP8vfpHWEDAllHe2tUKEhQaO9a/TYk9nqTR5nPJBAx2JrZRr1UObM3D4ROohgQ2hFQnblOs/I+hIrA/F7Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hHikxe38; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=s0c7nWYP4a8uTeRDD/AlFLRmr5kf20OBf9Y1FDUOwoU=;
	t=1761552703; x=1762762303; b=hHikxe38We3QxevWDVihu76VW/ChWJF62jDRt2CDR8gDlXG
	3L9KxvlLbxGoAk4NKHkD5X0GcCgrSNP5LB0i5dBtYxUs/7hs+tipbI/fczC6oBJg22lrA6bqKKHtr
	Dumo+HWYFk8zTn4zs2wWrXr5Ey1ialjkqheo4dGl3dqnk4b3sHQpGRUKDZwj2eJniZDajr4zf46g7
	URich0vy3+Bg6cDAVgRDTjyHSUFa91NN5Xk4poOCPTibywcOY065keeQZCGybPPRfjmMQqVppvZsV
	wCMbBivj2VT0PeXkS4/jjsOMhBP/8g6uPk3KqTZJCeItxL2JpcvsFEePQWKiW0EA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vDIKE-0000000ADkt-0E1z;
	Mon, 27 Oct 2025 09:11:34 +0100
Message-ID: <fdea25fdcd19079988bd3ba38be8fc88e39af9e1.camel@sipsolutions.net>
Subject: Re: [PATCH 0/4] wifi: mac80211_hwsim: code cleanup patches
From: Johannes Berg <johannes@sipsolutions.net>
To: Amol Dhamale <amoldhamale1105@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sriram.g@kpit.com
Date: Mon, 27 Oct 2025 09:11:33 +0100
In-Reply-To: <cover.1761078139.git.amoldhamale1105@gmail.com>
References: <cover.1761078139.git.amoldhamale1105@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-10-21 at 20:50 +0000, Amol Dhamale wrote:
> Fix all open checkpatch errors for the mac80211_hwsim module.
> Patches can be applied in any sequence.
>=20

Please go play with staing or something instead, there's no reason to do
random checkpatch cleanups on this.

johannes

