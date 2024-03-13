Return-Path: <linux-wireless+bounces-4672-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 760F687A460
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 09:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3263028340C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 08:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E231BDD9;
	Wed, 13 Mar 2024 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rq0bhvdO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB791BDC8
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320285; cv=none; b=nTf5sIr/ZueOiNFJ28hTqgz8FMVgYoOd5bEPczbKjb7AJabAnvxpt4qAwIU5EOEvVOG0MAIKlBnhcECGRiX3EJDecHVqSjtBLXb8NtvGga7j3vZRg1bav+bDnr1aAkWu0pK7ul9P/hIMYFyMZnjXOJ8b+skCW6MMIzrjCt+++hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320285; c=relaxed/simple;
	bh=kfDt/vJKTdvg62vRt9dBd/mdmcdvliQsQjMGcnmun3Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=YY5IRI3LkXFNDu8JgN0LLPjkrAczOLQrosjORZj2Rg3/AnsDI6gYIXzZI0aMmutnVR7KHKuWv986iU4vKenv6tTjxKyCHhmY1f+wkOGZpVA5rYgAa7haBMrd3PsVpHwEmP2dWrMT9dho9RO9G/RJQqDqw5W9BFlhgmAjVmxb+0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rq0bhvdO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F56C433A6;
	Wed, 13 Mar 2024 08:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710320284;
	bh=kfDt/vJKTdvg62vRt9dBd/mdmcdvliQsQjMGcnmun3Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=rq0bhvdODem8H5mNKhAsqwMwKkx3emuYfZA4KdqLS+znuRnqD+kT2BVJfRzXoWQ0t
	 oMsVa3c4UDx1psrt4baEGgdzJka71wv5lohYUHdW5VQxvqm9ZCvM6l7fDT2liQtB3+
	 QHGB6V/RS91kVe+ul8MaOHWt8eirls5GeVZZpuLtT+Z0D7EPspmMtJgrzOHbPBhIEH
	 KJxymNi9XVshWqHSCJXt+VTr+/2BYNtTNWK8esBD/qCNgLhiA7bHcJPmsJJofJUMcx
	 duORxfP3sFGCVFRhvviaPW92P9uK9rVrvrzWqvzT4O5P/iEHqsHnEcoi9ByacEctRw
	 VwQAZwY9ST/HA==
From: Kalle Valo <kvalo@kernel.org>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  Ping-Ke Shih <pkshih@realtek.com>,  Larry Finger
 <Larry.Finger@lwfinger.net>,  Stefan Lippers-Hollmann <s.l-h@gmx.de>,
  Christian Hewitt <chewitt@libreelec.tv>
Subject: Re: [PATCH 1/3] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
References: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
Date: Wed, 13 Mar 2024 10:58:01 +0200
In-Reply-To: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com> (Bitterblue
	Smith's message of "Wed, 13 Mar 2024 00:18:39 +0200")
Message-ID: <87jzm64ig6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:

> Create the new module rtl8192d-common and move some code into it from
> rtl8192de. Now the rtl8192de driver (PCI) and the new rtl8192du driver
> (USB) can share some of the code.
>
> This is mostly the code that required little effort to make it
> shareable. There are a few more functions which they could share, with
> some changes.
>
> The only other changes in this patch should be adjusting whitespace and
> renaming some functions.
>
> Tested only with RTL8192DU.
>
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

A cover letter is would be really good to have.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

