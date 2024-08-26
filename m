Return-Path: <linux-wireless+bounces-11990-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B408F95F282
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 15:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DDE51F22B6B
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 13:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8F9185933;
	Mon, 26 Aug 2024 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zxlu1qTZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC8917A5BE;
	Mon, 26 Aug 2024 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724677965; cv=none; b=CNHgqd1J565B2nAYjObFJTeCZIzKLSktyEQHej440zwq39G8GtZHH/Xp14fLhPJJ3waD/853nIP0QGrqAUcMh5CX+Vs6sj/TxMjqjiW3RKDYEUDafocVy02LQeY8DAhMh2EO7qd1/UQmkzhAWnT7Lu0+ZI0lF6wfM8bDw7JsPWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724677965; c=relaxed/simple;
	bh=ALoyF9ulJjuvVQuI6CucHC2wH9xiZ0r0yZsweviQ2zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgfcB8NfAW1gDSDxmMNKdpCkOlbZeuxa2SYZJuWd24BqaFMmsclRUbSLRFYSWIT6obDA5msPla7ymPtN5zYP1rfs1hH6GzYK7C3KZ0OJ2UH9SyaTIHJ5qnU6z2LWWYzxcWYpkG82wZjaNfvG4Dz5K3f+76u7EZI/S5O2NZh3OYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zxlu1qTZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BAEC8CDC3;
	Mon, 26 Aug 2024 13:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724677964;
	bh=ALoyF9ulJjuvVQuI6CucHC2wH9xiZ0r0yZsweviQ2zU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zxlu1qTZX2t15uZcs5YzKeyO71kqgUWVS4+RTSJQvbWEZKRMGzQmlAEhg1oDWlkLy
	 B87mHCaAsf/Tet2A04ZpAC5HsRycVmo3VuBALF9xOqtrgjyuMoJrnxBU6jU8HPYtew
	 qjP++hG0nzTNpFTr7n1mTSxjcUY1rKZJ8xPpaI3A=
Date: Mon, 26 Aug 2024 15:12:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: kvalo@kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, sergei.shtylyov@gmail.com,
	syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V4 1/2] wifi: ath6kl: Replace ath6kl_usb_submit_ctrl_in
 with usb_control_msg_recv
Message-ID: <2024082625-quarters-proofread-1e97@gregkh>
References: <2024082631-upward-zips-f7b8@gregkh>
 <tencent_A037749680365C4BCC750776D566183C4509@qq.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_A037749680365C4BCC750776D566183C4509@qq.com>

On Mon, Aug 26, 2024 at 08:29:56PM +0800, Edward Adam Davis wrote:
> ath6kl_usb_submit_ctrl_in() did not take into account the situation where
> the length of the data read from the device is not equal to the len, and
> such missing judgments will result in subsequent code using incorrect data.
> 
> usb_control_msg_recv() handles the abnormal length of the returned data,
> so using it directly can fix this warning.

what warning?


