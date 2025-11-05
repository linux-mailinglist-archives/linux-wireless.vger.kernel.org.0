Return-Path: <linux-wireless+bounces-28603-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 093A4C35960
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 13:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA3E18C02D9
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 12:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34660313558;
	Wed,  5 Nov 2025 12:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="CRM65WrD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E71312815;
	Wed,  5 Nov 2025 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762345193; cv=none; b=cnscp/XIJsjyFdwJfGjfT6cCwvxRMAoaEMbA77yVLuQ8i0DIuIOZsx9/S+5r4tyd3roEEAFOayu2W7QSFunvL4R0QKuVH/7sJNrePVXWp/OAdApw0XQp9rzhqMhDlOGAhTw4cvt4jiLA4tG4/l10u5O+a4Pg5y2qk7NX13Prf6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762345193; c=relaxed/simple;
	bh=v+cOKLS0mXGI3qhe4fSNa1rYmF2ZqvmWdVpVTHz/8rs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S4UyAeR6GqnjR2FwPZx8yDhNOLq7nNorHm6awfas1yHBrOfuBD5LBRk3IPWzxjLWPBuewwwB/dDV+wvhOIBFR54RbqBS5+C6NiBeuhVJke05jvfj9TJYuyXOaesd9fcfeZ1LK94Ayw+r168Np7gWX2KhGTF/Ll9hz/9WK030XdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=CRM65WrD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=v+cOKLS0mXGI3qhe4fSNa1rYmF2ZqvmWdVpVTHz/8rs=;
	t=1762345191; x=1763554791; b=CRM65WrDCi6ij1mGWY1VLpU9ULsJ6zF0AhY1NcJD6J/w3id
	fIp5rli8UiATLImtdeHKsbglrcs8LCLlKUycEjD0I/EanOO1FbY5aHClzVmkHHqXBElDN4w+B8oDR
	w6AY4vkltj0NJVodpz7GzJa8szYlJMan/RhvPYhRWbwxpLEcb8e4HfE2b5eKUPF5fKL2ULLvaRhS+
	5AGOil2CPHxIbHS1SxekrpuwGs7cxS7yGKjKsUaAihEeCBOyap1+uDvMs0B7tFsQQ4NYyifWhgSKx
	JxPUJpiMgqsWAWDiXs2/uDS+U1zn6Vh2bA91NRBV25m+SJ3qXAJye+MmE5pdGHlQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vGcUI-0000000Ey2O-0HBi;
	Wed, 05 Nov 2025 13:19:42 +0100
Message-ID: <6156fd13fab5131c13b76acc84cb72e3c8b69271.camel@sipsolutions.net>
Subject: Re: [PATCH] net: wireless: fix uninitialized pointers with free attr
From: Johannes Berg <johannes@sipsolutions.net>
To: Ally Heev <allyheev@gmail.com>, Miri Korenblit
	 <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Dan
 Carpenter	 <dan.carpenter@linaro.org>
Date: Wed, 05 Nov 2025 13:19:41 +0100
In-Reply-To: <20251105-aheev-uninitialized-free-attr-wireless-v1-1-6c850a4a952a@gmail.com>
References: 
	<20251105-aheev-uninitialized-free-attr-wireless-v1-1-6c850a4a952a@gmail.com>
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

On Wed, 2025-11-05 at 17:20 +0530, Ally Heev wrote:
> Uninitialized pointers with `__free` attribute can cause undefined
> behaviour as the memory assigned(randomly) to the pointer is freed
> automatically when the pointer goes out of scope
>=20
> wireless doesn't have any bugs related to this as of now, but
> it is better to initialize and assign pointers with `__free` attr
> in one statement to ensure proper scope-based cleanup


Yeah but ... eww. Please read things like coding style guidelines before
you post patches.

johannes

