Return-Path: <linux-wireless+bounces-29230-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D93BC786B1
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 11:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82E5D4EE8E8
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 10:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B9B33BBAF;
	Fri, 21 Nov 2025 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6vMvJNF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9641312813
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 10:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719620; cv=none; b=OZ+O8S2FF8DaH8XPD8JR9NTCnZUm0hqhrMI4Zqbw/DbAFc8RPik559l4akooMu3SQKo44JjoIgP26nLmHQQkHdY6QA9JmagR1y06i/RI/fS25IJ1InZxlYA2QE/X6keShlXRtfMYYV85AhnQ8kWnnNAUp4fyu10CRrRcboH33QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719620; c=relaxed/simple;
	bh=Y1L0+y505YgChJ88kTKvVh2AdNyK99G7uNt6DKubeHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBLjhUYIv3y6C+2PQIZlMY9jLqGI7+UP6Devli9PelX/OhUPpldAqycoOnISsqur3OqyvVsruXizZ+bQ5qHFRsIoUrsze1UnB99axlUm0iBvsqHKivZ54axDES6ODqeBH6Ak4WcFdTCeHVOqvDjMv6bw8WYLf68sXwLAogaBUOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6vMvJNF; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-340bb1cb9ddso1411388a91.2
        for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 02:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763719618; x=1764324418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCNoZ4dRyXS+FDaS9bTbZT2/5dpNe39o/44FrsZFON4=;
        b=L6vMvJNFeL4dZ8Ukq7vvKW5UZ06GCxk28w07qhOlv6zcDiXEEe16mfd7wjYphrCkgB
         C35qPdkT8zjTyIA7mthQo6J1nxIH/Liqb4SCGKzdS+jiuBgslaz5+w/mmdqtND/hoTS6
         tIs11JG9kR2y9zy42bedCDLSO+Hdt9pfStbuPBJgSowVU0tLcloH2ibAHp+L7b5cml9A
         S1JIjzY0BXLP0wvgKOfLGRB6+ehvt6acx9z4ZdSveqH679SF+YBwFiDOOJiiAGrqpaFl
         V6GHLuRHuR3n1YEZs7i/gUCKowmaeLocKeVVVoyiEzTXg56BzVl6ISpVY50Hsr/96avB
         CdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763719618; x=1764324418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mCNoZ4dRyXS+FDaS9bTbZT2/5dpNe39o/44FrsZFON4=;
        b=A8jeha0PNZH39jclFQFi4NHJzXy6OKsc9PNR6bHxK5tkWmM8RnyDNlG5eKd0rKX+r9
         BSBN9GfW4eq8uZL325PEWPsMB4my0UOjdzns/mXXApNSPy6k0yedi9Wn6uK6JtUulHGa
         njUeZ2nJdqtmULBXze1+tWRRqmRcxml1zx5hifuBH8f9CDoo0Nh03F6t/hLzZh3snUcA
         nP1hCiK089H4sOqTPCH1KBQx1kKJLqYpn6vIn7ozSVdC1CQFWVuzx8nbYUJONkSjClvm
         VZ1JI9QDM0sWVxmdVpmBHRSKrBdffKT0MX2MppzGXs8JgByMyezudft+Xc+AwpRvV0AG
         qv7A==
X-Forwarded-Encrypted: i=1; AJvYcCWsJjm/KUfcle8A+EVotHpAnk/W7f6NK1xynys8yGpHWs30PwiqeYGiRhd++xnT0rfKgfTu8wa30DsMGBa3vA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKlkzvPm1BWPuizPDU55pw8sfW3yJWE4/EVWs2Oa+Pp/5SFJQM
	Ux+2nL3KC8KDilqi9MiLJknI6AYc8OjSP7BQ1jvdXSZTz8UWXsHlmX3ejcPmP7u2
X-Gm-Gg: ASbGncsnhCjRrEEjrcbJaHvp0sCDwLCW/Ola8KrhOCDFLXqTEKLPNYLuFthsTmaI3oL
	2TBTPaq/IZmfAIirMykle7vVvFWAdlAqF+pIrMeLpEWAiWAqsRqlAQegb5jSABQpsHiulshdqF6
	oV7NYjTwbt9Qsi+YNQGo8LnWzeUc7+68x1gXVB7/xfwRkvImgN8XXhWWfE2gPbjmw9oOBm/rvlZ
	qqkrtqJlERNbK494pSX63zO+/uC6srN11MQsPKT2p+trAlGZJok8qz5nhOTzX/dfiqlv7+O+TMC
	TOQMclJ6YE+Iilz8gQ1xEMLx7jH3evVkGNIFb995LwzNdtqORkOxoxV7TwXwM6Rpl8RdT/OhFbE
	c98TKmmcSnkl8KxJByPUIgIHAHvhy6gedEHTllJSaDUVuTXWHgVAWuYmQWyGAvGQkXm4bEaGpak
	8fb3imJ1i3/A2OHEguxxe+yfdXWGsl4upHAK/Cf3o3qQ==
X-Google-Smtp-Source: AGHT+IFYPoBuMPo4ymRkW3gUOnn2CpfpfKLAEIqUhCtAW959aOaUDxEHxh5S3+CFp8pXWSWDXx35LA==
X-Received: by 2002:a17:90b:54c5:b0:33e:1acc:1799 with SMTP id 98e67ed59e1d1-34733e74d45mr2265466a91.14.1763719617935;
        Fri, 21 Nov 2025 02:06:57 -0800 (PST)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-347267a137asm5234351a91.8.2025.11.21.02.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 02:06:57 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: gustavoars@kernel.org
Cc: Jes.Sorensen@gmail.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com
Subject: Re: [PATCH][next] wifi: rtl8xxxu: Avoid -Wflex-array-member-not-at-end warnings
Date: Fri, 21 Nov 2025 18:06:54 +0800
Message-ID: <20251121100654.9125-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <aR2I9Sere0W-4VZz@kspp>
References: <aR2I9Sere0W-4VZz@kspp>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear maintainers,

With this patch applied, my system always freezes right after the rtl8xxxu
driver is loaded. is it normal? 

OS: Arch Linux
kernel: 6.17.8-arch1-1
test devices: RTL8192{CU,EU,FU}


