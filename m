Return-Path: <linux-wireless+bounces-1129-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F1D81ACB0
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 03:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3141F22ED9
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 02:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A299C4404;
	Thu, 21 Dec 2023 02:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ian7/FeH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2B2441A
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 02:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5c21e185df5so279844a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 18:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703126321; x=1703731121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1vJGbIHxG2ZsYy3EApEYIrka9GfydAEUv+b6Hz8AzfM=;
        b=ian7/FeHw6NJNiqpPaz4eJcj6EU8bgem2UJ6Uw5zy37pldCXYlh7dA6axpDnAJNZ6v
         QYxNrDbChc0c1RUMOOUAQpNYaOj3mGBkAjj2UlhL8BFgt9g9Abu/lt03COzRvYkY1f76
         gathwJDmWev4kvIPr4U5WYpW+BpJihYY0t0uQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703126321; x=1703731121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vJGbIHxG2ZsYy3EApEYIrka9GfydAEUv+b6Hz8AzfM=;
        b=qVSx1FTu/L/iNa4kKLu8qJO13OsdlULgcs5znpLG/GM1d6dYdip8LMeRhnvs4KLh85
         tMgybSfFQ/5/uJS2eAhZkpdewWeRoJXZw1LpFhxuSeO+wxpnjdoRvBx34KW7+VhdNHTl
         5CjhDVMkY0eLbxAbEUqu+43eIDEhyKoJ/qBHYrefqP7P5ZIngK3T3yVYHUq/ZPfDDCkH
         aKEgIBABaveQPx6GFYAx5hnkbt5/QZTceYstfSGuT7GotwhVOlWj7VhmT/6ub/LqHC/M
         lWN9UEW/s2Bnx380Umv0lzb3F3MT1U/0HxwQ2C0MIxwvBGGf2F0wYSW/24s8LQVImAsQ
         GuRA==
X-Gm-Message-State: AOJu0Yw3WHNOVWDuheIc+hl7UKLW6ecuAP3bicK5FS0ACdoTun7lcsOB
	I6vAqf6l3WUDUJw243V06FqgHA==
X-Google-Smtp-Source: AGHT+IFZTzHJljAEY9dBckgyqNlZpe7i9t37+5ZwyzFVa+SsJmG4tRtrmgdjSlzgL/JHtsz/d7gP0A==
X-Received: by 2002:a05:6a21:6d99:b0:194:d254:301a with SMTP id wl25-20020a056a216d9900b00194d254301amr735237pzb.119.1703126320783;
        Wed, 20 Dec 2023 18:38:40 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:dc4e:6304:4aae:aecc])
        by smtp.gmail.com with UTF8SMTPSA id w128-20020a626286000000b006d8840a5923sm471801pfb.166.2023.12.20.18.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 18:38:40 -0800 (PST)
Date: Wed, 20 Dec 2023 18:38:37 -0800
From: Brian Norris <briannorris@chromium.org>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
	stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v2] wifi: mwifiex: fix uninitialized firmware_stat
Message-ID: <ZYOlLanvv6DTGSw1@google.com>
References: <20231221015511.1032128-1-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221015511.1032128-1-yu-hao.lin@nxp.com>

On Thu, Dec 21, 2023 at 09:55:11AM +0800, David Lin wrote:
> Variable firmware_stat is possible to be used without initialization.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> Fixes: 1c5d463c0770 ("wifi: mwifiex: add extra delay for firmware ready")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202312192236.ZflaWYCw-lkp@intel.com/

Repeating:

Acked-by: Brian Norris <briannorris@chromium.org>

