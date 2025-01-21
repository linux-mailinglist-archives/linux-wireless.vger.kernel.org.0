Return-Path: <linux-wireless+bounces-17767-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B74A175C5
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 02:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2031887D16
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 01:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E615028C;
	Tue, 21 Jan 2025 01:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="P3YJWwDc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598D83987D;
	Tue, 21 Jan 2025 01:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737423197; cv=none; b=gojxdvuReeUyqIDRCAYQV8ohOqWPSZV0xIk3vLfePb26fn0wsArkF7YSlArfgThSkMA+pTo6OifXHl9T/iwh5CK3mxz2dNE9JB6CVPz53gkUSoa/vRIx9bgcayUXSlW4864sT6nRMF0KMKps2+OglX3yDhHkHXkpLOl/2K/jdfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737423197; c=relaxed/simple;
	bh=hQ1GbYpIYxzKa/9yrlWNZYKjvOiaOWEW8vlOrZI7xz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oEBMweTnrHv4zvDiwocK++SAYdyHa4tM+fp4OBS19QrizQPS6ELRI5byJ4q1w+F3vfW+ZxttSAcWegvqDTG9n5dLACzvlkMHcwQ/rYxOSRJsOKrdgq8uOLKRRYpLfyKoQElfBRPae8nyuihwQ+sQ2j2E25HQq7V5JOhLA/BZMIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=P3YJWwDc; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=LfSU5ttDd+e2OhkreM5FYt5iFonOHi5mJEFH1olPS3g=; b=P3YJWwDc22e67qjx
	E+8/5NFPsnESw807VhgPsGOQe68zSuqvyFyjSFhiHSr5qG+ux0AQiOQ96ZiazB8xDJasIWQekU2MV
	jeqGQLnqr453Cwhi02Uiojg1jJysUm7b3BlMjzrmXi7T61nkrmsBqTehxqO+pVtlTiQLj7hH3hJRa
	v7/aRlYlK3MjkgVzwCv8i+2F9Fks9JqLZDqDzGlsv+q+9ZksWcmgaKb5rMLuD/kL06RzuzEmCue7c
	uqYmvZiy/nunxnEBnQZO+NlqBAAModQXsP2U3t9bbVUHRaqJauqbgngT7RHTgEvOkGzEDpGmwCRjQ
	wjTts55Lsb6boNfozQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1ta38W-00BEI2-39;
	Tue, 21 Jan 2025 01:33:00 +0000
From: linux@treblig.org
To: kvalo@kernel.org,
	libertas-dev@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/3] wifi: libertas: Deadcoding
Date: Tue, 21 Jan 2025 01:32:57 +0000
Message-ID: <20250121013300.433538-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  The first two patches remove functions that haven't been
called since a commit in 2010.
  The last one cleans up a bunch of unreachable code and
never set variables, due to the functions that weren't called.

This series is build test only, which the first two are fine,
but the 3rd one might be best to check a bit more given
that it's actually removing some if's.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>


Dr. David Alan Gilbert (3):
  wifi: libertas: Remove unused functions in main
  wifi: libertas: Remove unused cmd functions
  wifi: libertas: Remove unused auto deep sleep code

 drivers/net/wireless/marvell/libertas/cmd.c   | 143 +-----------------
 drivers/net/wireless/marvell/libertas/cmd.h   |  10 --
 .../net/wireless/marvell/libertas/cmdresp.c   |   1 -
 drivers/net/wireless/marvell/libertas/decl.h  |   4 -
 drivers/net/wireless/marvell/libertas/dev.h   |   4 -
 drivers/net/wireless/marvell/libertas/main.c  |  88 +----------
 6 files changed, 6 insertions(+), 244 deletions(-)

-- 
2.48.1


