Return-Path: <linux-wireless+bounces-30625-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A51D0D0A1
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 07:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15C873017EF1
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 06:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34E23126B6;
	Sat, 10 Jan 2026 06:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jMKdQjwK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8434C241103;
	Sat, 10 Jan 2026 06:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768026874; cv=none; b=fPYuwoH9PgylN7bqQ+CqPmniNjjfhLTZwMxAv0kKg6eiOvirfElCjq80rc4bzR1+pwQcirXm5Yn399Gn5j5/szsl9Hy4Sf54vl/qPEH+VVlKOxLbGi+VmfRvAVPz6zV7xMLc65PP+fm9vJQ8pUL9lNT+wpsrT7olkBx+C5onDas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768026874; c=relaxed/simple;
	bh=kBaNFEKarF7MUFvOO5Lb7V8Omi+vTfcoqG6XE1DvCbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOFiyycNaVi0nFyE7XLdQ9PourF0rzaecyJe9Uiofew0LctsjKu1cwfllxiimbdZx/w4ALzBnk47rm4uKgSfmMvvJZoVhX4XUC22IXwYThC9ETffDy/TV3rE0+yozNqAf/VyAzf72OWXPzmcqmTWsUzs4T855fuKGTuCqjawQII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jMKdQjwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7843C4CEF1;
	Sat, 10 Jan 2026 06:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768026874;
	bh=kBaNFEKarF7MUFvOO5Lb7V8Omi+vTfcoqG6XE1DvCbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jMKdQjwKYHSan5xawo3TJxRP65GeEi0mFXo6bHbMt8jee6RmGYVsRiHz0tLAn0ASw
	 Ymrv6w2FXPYIgc7NQmlN9zhFccQ5mFOjyXUCyRxyjNgjc0isEXNF8vv07BQBewg54U
	 7NDz9xnNdIeeRSRjUx+7gdT40/Mt3fjgd88ulNKk=
Date: Sat, 10 Jan 2026 07:34:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: cjz <guagua210311@qq.com>
Cc: linux-staging@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PING] [PATCH v4 0/3] rtl8723bs: Remove redundant atomic op and
 replace global io error var
Message-ID: <2026011004-basis-cursive-74f7@gregkh>
References: <tencent_8B6BB2D2C0BBBBF53D76839D23A902304C07@qq.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_8B6BB2D2C0BBBBF53D76839D23A902304C07@qq.com>

On Sat, Jan 10, 2026 at 10:30:39AM +0800, cjz wrote:
> Hi Greg and maintainers,
> 
> This is a gentle ping for the v4 patch series sent on December 22nd. The key changes of this series are:
> 1. Remove redundant atomic_t operations on continual_io_error (no concurrency scenario, atomic ops are unnecessary);
> 2. Replace the global continual_io_error variable with local error_count in SDIO functions;
> 3. Clean up unused old functions related to io error counting.
> 
> I would appreciate it if you could spare some time to review this patch series when convenient.

Do you have a link to the patch series on lore.kernel.org?  I don't see
it in my queue.

thanks,

greg k-h

