Return-Path: <linux-wireless+bounces-23330-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DFAAC15CB
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 23:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4552D7AF3A6
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 21:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B22125229B;
	Thu, 22 May 2025 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnV+HYUg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5283286358;
	Thu, 22 May 2025 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747948105; cv=none; b=VBq/y1kaUAsBM9e/crgTXBIyvXmKKCFGpFSwo7d/yQoh2l0wbX/8fu//wHJqC2Exsp5IlDWK5qHskYzAhsFJSBWyd7MBxkZaNoHyCqA0e1akVUozA197m28FaHppkUvdeYYdQFnKzO9cYO+lu140EYwpyr1QnO3yTpYGWqYhGOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747948105; c=relaxed/simple;
	bh=dSi/1pkhbJ3GV7RkiiZY0nDlR/HvDT/4rNZxxMFXfM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h8r6bb/ziBnBkAm5za1USIqBfY4/c31mgE6eYy0jRWrreat+uK1EZgXIRp9eeRqILB6g2Ig8Kj52N3lTR6J+oQ2mv1Q0XdD8ezeaeyFe4uKvsYwcKz1qawj81ts8naudTVhmqd6Xyhb5DUHVISFkqoDhhHljmG25tKDg1JWadwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnV+HYUg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F62C4CEED;
	Thu, 22 May 2025 21:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747948105;
	bh=dSi/1pkhbJ3GV7RkiiZY0nDlR/HvDT/4rNZxxMFXfM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hnV+HYUg3owAYVYhn373cJUwPIlZnu//ZPGcWMeqvz02SvvhAr6PPHnhBbpYPkfAP
	 AxK+XJGfB/l9hBTd3IpUEz3hUrxdl+LRfqSOP3wJ5MpEms4lFgDjAebGa75j+zouUM
	 2KD1kljInamf6NGFTnjeN551S8IfYlwnftJNYUFZK1gJEwS4TDJ/CPXihEUT7DOVd8
	 SI6sHghIJ//NDPhOWm+DYeicbqIzVVFIy6odCFoAoLI/oBvadqPb0U5iMfLOXL82OF
	 BB1tUHZcVZFgNrKfhe71dLNOqoHlzNnGlcOeqwIs90FGV82CaTv+LXxBU7Jt4AYp/a
	 3Iy/KdDG5hU9Q==
Date: Thu, 22 May 2025 14:08:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [GIT PULL] wireless-next-2025-05-22
Message-ID: <20250522140824.3f62347b@kernel.org>
In-Reply-To: <20250522165501.189958-50-johannes@sipsolutions.net>
References: <20250522165501.189958-50-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 May 2025 18:54:35 +0200 Johannes Berg wrote:
> Johannes Berg (121):

Damn :)

