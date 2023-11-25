Return-Path: <linux-wireless+bounces-73-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E99AA7F8BD2
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Nov 2023 15:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE3C92815A0
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Nov 2023 14:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B93BD301;
	Sat, 25 Nov 2023 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ked7JVe5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E3518045
	for <linux-wireless@vger.kernel.org>; Sat, 25 Nov 2023 14:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29007C433C8;
	Sat, 25 Nov 2023 14:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700923717;
	bh=Bu5//kjJspOiaXvzhiIPwduKqA4hrH4OAkkljNG/AaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ked7JVe5kebzJGTY4cwvgKzVwjTYL4K0cZzOyNsRyZvd9PZ+VrOXyQicw9+r9YuN3
	 SPPCZsbL4uNEy3c6tk/z16BT9nkCozZYhzMwCbZUa5kYhPb/vc3gra+vTDb+JpYiwc
	 3sIJYjyazGkm+gNyG0Tpio2259t6lvOIH2Uj0LAk=
Date: Sat, 25 Nov 2023 14:48:34 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2 2/6] debugfs: annotate debugfs handlers vs. removal
 with lockdep
Message-ID: <2023112530-eraser-glare-44b2@gregkh>
References: <20231124162522.16344-7-johannes@sipsolutions.net>
 <20231124172522.0442774abc66.Ia70a49792c448867fd61b0234e1da507b0f75086@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124172522.0442774abc66.Ia70a49792c448867fd61b0234e1da507b0f75086@changeid>

On Fri, Nov 24, 2023 at 05:25:25PM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> When you take a lock in a debugfs handler but also try
> to remove the debugfs file under that lock, things can
> deadlock since the removal has to wait for all users
> to finish.
> 
> Add lockdep annotations in debugfs_file_get()/_put()
> to catch such issues.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

