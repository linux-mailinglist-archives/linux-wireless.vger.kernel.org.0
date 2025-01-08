Return-Path: <linux-wireless+bounces-17194-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5593DA05F5F
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 15:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12393A16E0
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 14:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372FA139CF2;
	Wed,  8 Jan 2025 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNzMX1tf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BE42594A2
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jan 2025 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736348133; cv=none; b=bSzlSUtFMnyfORSyrqAmh4tlyECiD5BR3EIDfNEuCJkvG8G44eMXahwTqU8iYdUfdYCkKSZkOKrtF1NyEjh8HDqnJhxaRsJPoyM+I20AlzDdOJIAUii21RTcDRtrUqv+dD9K4cuaU4nTH1iPv/mEXZzsrtEfzBFh8h5QH+L5vxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736348133; c=relaxed/simple;
	bh=hjjGdiup05qQf4O/tOO9M2RatpOFsooVKM2gkZhfeLs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ScOU4ZvV1yOVTlaRIDABBqkbuYdIGb42TU0FNx25bPRncrbp4aA1GzY1kctrrKJ2UxjtdfcWUN4rq45OxcFT9h3pbLLaxd8rX+Xxnk8uStrgte25btVJVjH8WsSEWReTcUnJHbLwbY5bRoBvSNwJVg0EWVEv/1JjuaucgZTILeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNzMX1tf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F504C4CED3;
	Wed,  8 Jan 2025 14:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736348132;
	bh=hjjGdiup05qQf4O/tOO9M2RatpOFsooVKM2gkZhfeLs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=eNzMX1tf56yVeSiIe8bKQ2PuUEQnLjiFkIDk7+PHH2Zu5LhLwq83UTnDxEZthc/nr
	 D65S6silhhaytYwa+O40rL47U7fOUCfjSEaFvDsdqdvtKIKOc0wK7PffssGVdeN2Tu
	 Ab+icgyXIxkHfkvHikvlL/XkmjMqQn6hxFEqamk6AQyz99zx1np4BrlJFQMaDz0CT0
	 QY+pCKbYorr8oxXV0+ChCtHlu+NW3PjUt6nVi2XCMyOR/XSrr6gQTsTVI4+Q7xoVu0
	 VGurvD6tGYFSkcie5d4+3jH7uZqiBv7lcOKjHjwZQ/8ed4H8fHnnoSG+2OGBKEZFzV
	 kd9uu3KLHvixA==
From: Kalle Valo <kvalo@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: johannes@sipsolutions.net,  linux-wireless@vger.kernel.org,
  "Somashekhar(Som)" <somashekhar.puttagangaiah@intel.com>,  Johannes Berg
 <johannes.berg@intel.com>
Subject: Re: [PATCH 12/15] wifi: iwlwifi: pcie: Add support for new device ids
References: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
	<20241226174257.6a0db60436e7.I50a66544dde6c88acd9abe4b31badab96ef04cfc@changeid>
Date: Wed, 08 Jan 2025 16:55:29 +0200
In-Reply-To: <20241226174257.6a0db60436e7.I50a66544dde6c88acd9abe4b31badab96ef04cfc@changeid>
	(Miri Korenblit's message of "Thu, 26 Dec 2024 17:44:53 +0200")
Message-ID: <878qrlqrry.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miri Korenblit <miriam.rachel.korenblit@intel.com> writes:

> From: "Somashekhar(Som)" <somashekhar.puttagangaiah@intel.com>
>
> Add support for new device-ids 0x2730 and 0x272F.
>
> Signed-off-by: Somashekhar(Som) <somashekhar.puttagangaiah@intel.com>

Is the name in From and s-o-b really correct?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

