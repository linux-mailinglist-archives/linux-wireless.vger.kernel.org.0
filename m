Return-Path: <linux-wireless+bounces-18589-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EACA2A4BD
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 10:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE541889D25
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 09:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1856226193;
	Thu,  6 Feb 2025 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nmx2wG7C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B387226175
	for <linux-wireless@vger.kernel.org>; Thu,  6 Feb 2025 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834580; cv=none; b=Ai289HVyiL0I0oqJCJanPQP01xf11m0ZGyTMgiSXcnxsuyISJVvEDBHoNYkC0TlM2ny7tD175dRUHVbdAAoEZGa1Nh/h8w/CFmt0v4E+TkmCPuVhzaB0ojgxa42o/f72u7UYsi8bAOglaqIKZYYJJtIPWS7/ToDBeyo7B0fq0v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834580; c=relaxed/simple;
	bh=MmtG/McS/NtVgGq7LrxoLWF9JY6WU3vHPrsJ2sphqFU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=envbwKLk3Ai97x0uo3xmeLL1Eh1EL4+iIB/sOZaP3Z9ZjjubRSZrT1jbs1othCYHxuIyOj591MSebGqgcGhfzU3PwtgjfC5FAGq7X+K2CpC8Rli7Or1CiRzxbWlNQLSNlxUecrN5cjRVQxS/fTnCQkUGf6OOMpOCRx7fxERg3P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nmx2wG7C; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MmtG/McS/NtVgGq7LrxoLWF9JY6WU3vHPrsJ2sphqFU=;
	t=1738834579; x=1740044179; b=nmx2wG7C24b/uI5kF6IYZpBUY3lsSZ1F59r45PCbmPXLT/V
	3o5IyqTFN8n2oCk8IB8n1siEhw5JcO+jw8qhhZSwe52h6UcshtNGkJ5M/ga8MYCBXvUztOTPq/Lo+
	chLCuOyVQ4tRB/0agToQ02gd8oZNnG8FXihbu5i+LemTbrOKcrRMKa7zm6Mfs88NqCjf9yFWNvvF8
	A1guAm1SejrfMpqqD2YV4+zUpKgerN2CFI9465qJHmAXm0D4yZzjU+IixUPR2+swdz3zE5J1jAFVu
	hruOuYnKfG4XXHm+s4oU568MY/20CreYsQf9wyvOXs7yA538lPldh1+NhrtJbKFg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tfyIs-00000004xQF-0ZTw;
	Thu, 06 Feb 2025 10:36:10 +0100
Message-ID: <e2ce9990d17bfda957145cafb93ae24b6a6dbe69.camel@sipsolutions.net>
Subject: Re: [PATCH 3/4] Undoing Macros with flow control statements.
From: Johannes Berg <johannes@sipsolutions.net>
To: jack Livingood <jacklivingood@comcast.net>, juliancalaby@gmail.com
Cc: miriamrachel.korenbilt@intel.com, linux-wireless@vger.kernel.org
Date: Thu, 06 Feb 2025 10:36:09 +0100
In-Reply-To: <20250205213202.404965-1-jacklivingood@comcast.net>
References: <20250205213202.404965-1-jacklivingood@comcast.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-02-05 at 13:32 -0800, jack Livingood wrote:
> Signed off by Jack Livingood <jacklivingood@comcast.net>

Please refrain from using wireless as a training ground for how to code
and how to send patches etc.

johannes

