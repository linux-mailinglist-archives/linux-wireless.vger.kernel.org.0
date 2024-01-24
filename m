Return-Path: <linux-wireless+bounces-2448-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3CE83AAF4
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 14:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7649A280A88
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 13:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C987764D;
	Wed, 24 Jan 2024 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMFdXy/K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BAA8BE1
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706103213; cv=none; b=bOS7BHYMYzT10gpQOLZgtISrAuB+MMuy8Z/uQk/tGqSrc5n7OgnLEIypa5apE7uJb1RwJImvFCqUA6UETBFdr3dI6p8kD7Aotdr/r6TkoAr883U7F7JvcyGyA3s+6Iy9rF3MBF56u3XBds4J/ui32wK2MgLnk2HpNG0rE60SkQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706103213; c=relaxed/simple;
	bh=DoomOp94MYQjW4P+ev9yS1HbxtHacZaSTyqA77i+0VY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GmithXOKzDo4Fb/YW9Skf63qdOZS/eR3zd9M7yag1kr348iDb1MwfIH5rvLWzHTNQh2WjUYcR2NhQQGx6Fi3bykud59ycSxLdQeqoQrKC9v0H6fSgP+zdOTAR3x1P81S/W5D7Cb3bUWq3XQ8O3UsIkRjWD7V6iIp9Wx/OUa0LRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMFdXy/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB09C433C7;
	Wed, 24 Jan 2024 13:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706103213;
	bh=DoomOp94MYQjW4P+ev9yS1HbxtHacZaSTyqA77i+0VY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dMFdXy/K92NyzIXFNOBbKatNXgrlDuz4+VQD0n3yS5F422XwymqKCF9C/Q9MfgScB
	 5qnxPODz/x0buym/VACF7Qa13PLN59yo/uBZyDJheM+oktXc9uS6ZqlZHHdCLzy5Ct
	 PdKGa+v8ooK9GmFCzF6g3YqX1ljDpCPpU+NHWNiNETqE9WYr57k1Mcdc5J5ryh6GE3
	 rMdAJgP9OqAxFC1noDa9RcJP4MnXPoql13b/fYq4Uhyu1MCierdTLthF113qtxkVzG
	 bRnUWrmiYKVpZ2dnANZwfh6kDyI0MpDQxwsaUCaYqCxhdzB4aKd8lsyTB0W6JeeplT
	 Zy2NwFn7jBNxw==
Date: Wed, 24 Jan 2024 07:33:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 2/2] [v4] wifi: brcmfmac: handle possible PCI irq
 handling errors
Message-ID: <20240124133331.GA351271@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124092738.186493-2-dmantipov@yandex.ru>

On Wed, Jan 24, 2024 at 12:27:10PM +0300, Dmitry Antipov wrote:
> Switch to newer 'pci_{alloc,feee}_irq_vectors()' API and handle
> possible errors in 'brcmf_pcie_request_irq()'. Compile tested only.

s/feee/free/

