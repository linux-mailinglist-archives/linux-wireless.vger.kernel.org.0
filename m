Return-Path: <linux-wireless+bounces-1817-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD39F82C1FC
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 15:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8421F24E6A
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 14:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBC16DCF9;
	Fri, 12 Jan 2024 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1S3iAYdx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBAE64CC7
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 14:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F555C43399;
	Fri, 12 Jan 2024 14:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705070303;
	bh=KW7ed60w1PQm27Rd+trnG/PG3TKrhodYPisijJMp7qY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1S3iAYdxNp6r9rQUvwAPrNOWgnBiKYrUjzoumzaXJX4t/57aXDsmMfrLnkQnZGKlC
	 y8BbmjaFi7HawMIk5lmGlvDFrMqcUvUx7U7RaW9Ba4Ww/BmfLYxXwsZKwr3uEVN6bR
	 SXZb2DumHjqjuN9iPxPI2f6Ke/s/1+tZpb0gKQto=
Date: Fri, 12 Jan 2024 09:38:22 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>, ath11k@lists.infradead.org, 
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 2/2] wifi: ath11k: add support for QCA2066
Message-ID: <20240112-dangerous-cow-of-excitement-fdbaa6@lemur>
References: <20240109021336.4143-1-quic_bqiang@quicinc.com>
 <20240109021336.4143-3-quic_bqiang@quicinc.com>
 <e19baf59-c17b-4e2b-96d7-f4fc9812c99a@quicinc.com>
 <56282bad-b59d-4572-a6f1-1b905bf0edbd@quicinc.com>
 <da6ff953-07a4-4226-a7dc-b816f8dc5724@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da6ff953-07a4-4226-a7dc-b816f8dc5724@quicinc.com>

On Wed, Jan 10, 2024 at 08:20:46AM -0800, Jeff Johnson wrote:
> Unfortunately automated tasks don't parse cover letters. But it looks
> like b4 doesn't handle or warn about:
> prerequisite-patch-id: 640366721125b1adea0eeabd5cdfca5e91476e7c
> 
> And not quite sure how it would handle that.

B4 should be able to handle dependencies like that in the future. For example,
we can already locate this patch using:

https://lore.kernel.org/all/?q=patchid%3A640366721125b1adea0eeabd5cdfca5e91476e7c

Support for dependencies is slated to land in the next few months.

-K

