Return-Path: <linux-wireless+bounces-21632-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D43A91696
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 10:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237DB170787
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 08:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE91F22331E;
	Thu, 17 Apr 2025 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fH+Ci1ff"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CD021C162;
	Thu, 17 Apr 2025 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744879161; cv=none; b=pNatJHReqgVBz+85fxbSUSYn9DiHIK6x0SvzuAQ2f0G1kwtihN4JcNFAz7uL+AX8FcfijLQvkFoBUU3lzCFy5DVWulY0wGWSN6OzgFZn8dZA/diRuswnmWNCNtYtq/tLuGtkGAYoA5yMrnlNM8t499ri738auhLzet2VQJgMNC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744879161; c=relaxed/simple;
	bh=mnWlmqe4IrOKaDGbZ+1tech8QlQNZjf7aBIdhncEGXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8kWcPBzENBxOvC3e1l5okSnANT7PUYB7r91ulPfEOoyhm/yWXZY3tLQexA/eQ6EtjaDw8ilYgRKCqZQ+AvGaJ2mHKtMupviVbIH477bTy9QWXPJ62TLsVg5yK2+hrJNSlLoR/48jvMkPfKMzu14zu683GTwRejxsHwk0s9CClY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fH+Ci1ff; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54954fa61c9so649569e87.1;
        Thu, 17 Apr 2025 01:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744879157; x=1745483957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mnWlmqe4IrOKaDGbZ+1tech8QlQNZjf7aBIdhncEGXo=;
        b=fH+Ci1ffNhy3giUs8BL/WQVgwkIGj4Xld0ECWUXzkXSuZcgWeWAxZDybGONiCTa+gw
         vW2GaArkKOnLuRZbngOv5eBcmxakHKhr6GUFMBNrq1Wqfjjnq3I5HuBmQwnkMultNA1b
         tWdmALjqoY3ATBvjbPu73AePCUI9S9oYTH5XvihD0ZxxI4E00FFXOUBS5OAWiuq2V+/y
         +PuSdX7Bcdg/zL6Df/9mam4wm6PLxQxJPbZ9abOrzi4ykPwNjYT1afSUWtdWyxCP5yH7
         DA9BpVh8jRzbpY6fgQvPGd51UbqkNsbidBfGGIOVt5GWtisI/D3J4f1I3Uk5zIYFxicP
         m0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744879157; x=1745483957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnWlmqe4IrOKaDGbZ+1tech8QlQNZjf7aBIdhncEGXo=;
        b=gY2aFGnTDUU5K8Zv4aWjF7Pa7GptfYMbE1sv2aYI/GuBWcV+g2vRJniOJkLXHUm5qP
         s+/peAfOKkvHU+xG9wKDPknUOSxh6oVmbOqc3xsqx6fvOjOeksvhk7TJqvNyJx1ltAHl
         G9o3MWxsVKAiobW1DlOUdh7R1HrfIqNcZf5C9Ct/6HqedVIXiYif5nqIGkbO6zDQAESd
         sL8jjb2TPx+GdOwUQQNmY2v55EnWrE0AHh4Hzbrl9KCsIxjCKE+9Z+Y/QWAiB76xLXRO
         3N+B/kvH/NWMCy5Jzgyuz6T9eiQTcBOOcvH8HM6s+jU9uf3wPeBRpH6tH8BYjUL3jSCd
         VLuA==
X-Forwarded-Encrypted: i=1; AJvYcCUQETTd5oDfct8lX7vQGjgfNk9ssMJs7buLroOOscVBMPhI5GHH8qRMvPn4zUUEZn9K6Dqn7PlBYFhiIrvjhlI=@vger.kernel.org, AJvYcCXu+g0IhnLDZ++PO2dn3mITFZ1z8sPaj9uUkSlT1fwo5tq/yMU+JGTqIYdPKYWFCh6K8kV65GKRBXiPZks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRxbGmaV1cRNZP8/9xXLX/bR2osTvVdwd23wp7Yr0/Edl6Rr8R
	oMAahLYxgEh2C9AGuHiCnkVs+ZMHkLn03sZ76VkjJ1qvcRAVco0WseiYeA==
X-Gm-Gg: ASbGnctXZlTnvAtBXETBOWCMszWGYJGlr224KauSS5rcRGfm5hckv6jwIzuxxihrJFl
	ed6Z8qBykJafMO8H2sXQf55QS/5tftAue8sjsLxU8uWHu+2HSxz3iFdwGPS6GOd27KNk5Msqa3Y
	pJi+7vscbTXWmyJ6DnKmWnBYQpwWFpzMaqpQQdiX9ipnvbov4SRpsgVhDc9zzRMPW6W4BMLNbP4
	LesSUEQBnHdfoLQ3EopeXcCW0kHv306ik+VemVAdVjc6r7bPOYi9eXkZ43n5KfxFl2rXVbiIHgN
	U3qlportzTP7ybXSoo0P3ghAQxkgFf1x3mrH
X-Google-Smtp-Source: AGHT+IHa+OV9uWC95P4ZIC7KOF9Q2HCxY7fQmZuEL8m3yN4+QqZq3ZVQUPgT79ckX8yjmWEsakpHRQ==
X-Received: by 2002:a05:6512:4028:b0:545:aa5:d44f with SMTP id 2adb3069b0e04-54d64aab1b9mr1552456e87.30.1744879156862;
        Thu, 17 Apr 2025 01:39:16 -0700 (PDT)
Received: from localhost ([83.149.199.15])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d51006bsm1910467e87.170.2025.04.17.01.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 01:39:16 -0700 (PDT)
Date: Thu, 17 Apr 2025 11:39:15 +0300
From: Fedor Pchelkin <boddah8794@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Bernie Huang <phhuang@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Bug report] rtw89: 8852b: IO_PAGE_FAULTs with beacon filter
 feature enabled
Message-ID: <fbkxtp5wb5tv2t7rotvtbjpszhqdy3tm2jcezdggwxv7iaszex@k4iuy57yruyt>
References: <uidltsdsuujrczrtzgerhh5cw2tztxktfen6yvztnc7gttzgvk@jccomj7f4gul>
 <148ed65c53be4ef29246d372dd0fef8e@realtek.com>
 <z54thedngt3wnhr5bfer3yg7id2c4uqgw2jjvyausv6p66ys4k@guqol77fpugz>
 <dcf695a6621f43e38a20eb860194191a@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dcf695a6621f43e38a20eb860194191a@realtek.com>

On Thu, 17. Apr 01:05, Ping-Ke Shih wrote:
> Could you help to test when we have updated firmware?

Yes.

