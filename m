Return-Path: <linux-wireless+bounces-11393-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C147951413
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 07:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2551F25440
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 05:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20566BFB5;
	Wed, 14 Aug 2024 05:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrZThKw7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4D3481B9;
	Wed, 14 Aug 2024 05:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723615108; cv=none; b=X3t/sI9JboHZE57Y6V6DAADB0Jrz2KE4ZgBdg79ST7IHH15t8UqjsCH1wlYRT+QVvWpzzSwjOu+5YwNmGRPf6LGCF0c6obNFFgB7vSb7ImGsHD6El7GzNRtzn4Gt1vzcIsGKLKOWmMm5YuyMV7QMAbRuq6iR6Ni7+c7e0TRlTk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723615108; c=relaxed/simple;
	bh=5tXHn0K5SkAJ+jgWL6wJ7H8EVkfSAfNHrxLXNufvRSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=euYpRrPf+x/OtPcfDRzQfN/7G8jMPgqLHGRIrmrBiWJppY4u0KfUWjMGKFH26stPu7vjyHI6qNdrhcDHrVmhiRyQdJ3+yBR+QoOS0iYEjbJyQVHQ+CIF/r44Dkyu8GIoiEVYAdY7n41dZSk9lsvKHv5f+9QrbnZHWc7llugUkws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrZThKw7; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-70943b07c2cso3900931a34.1;
        Tue, 13 Aug 2024 22:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723615106; x=1724219906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOGwqfLdO1LRJs7tntcM+ssKA5Nit4pcjRhwD+QLbGw=;
        b=LrZThKw7oWcMrq7PPnupJ8TnA7eS8ifJawoEttkPQ3wkKD/yKjkde/7ghFJgp1+mN/
         XohdKgedjNV1gaH7lzqOz5B4DJpwEsIPZkj2B6HufpQxNoFScqzQwBDebQdzNwEXmWoZ
         6Awt0smWZC2W90cr11mn31c6L4d6hFD/xl+q9aZHvtRQ4CZIOT952DYhmtSV4uUy49hv
         1MickQoBuBvuUpf1oXKsCFjIVWwrZgSwSaE4QlEA7VxQ7ncnwIlQ372c58b3YIArH2Qc
         rdLVvg8cmyiQkvj6RIbXEBZU36G0XG560DLLlqDSH9AgzM9JUlFY0fgsirk+LdrCpo48
         sqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723615106; x=1724219906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOGwqfLdO1LRJs7tntcM+ssKA5Nit4pcjRhwD+QLbGw=;
        b=j0dwL1aOec0Pf1IbVfSWVWZ0pBO73+Z+2IkCwPyRoIxCl4IU61qEE8dnSYR626TMJZ
         bfNeZNsFodP8bVq1z637rdUZKOlT/URXPUKPHHQbwANlFvvE/KdFFoMnha+WFzWX863B
         bHcnPPBXO7n4npzFoYhDJm7C/NFqEefyehTdLuxR0kKO/DDPXuCbPV/jiEsf9r2iMOuM
         rO8M0j3PHTS5+FjVldWflSwy1FcjoBIGBOauaBEYI74vNxXaF/+43X/WEHaj9WtzySlI
         UV7zANs9Tv6v6GbLDZqjFuQH6DmloRCJv0/8zEPEkIRiAsU5zd3hjquM+atjupJsv3R4
         8ocg==
X-Forwarded-Encrypted: i=1; AJvYcCUuHv4AJxlfUSDOHqGnF0Oc2W+OQMyaPWZRDACziTjs6rmh+F3fyqBb15Tg69nu6BRnRt+0Qxj3qhfggTTkrC8jWGgdD5lSPenyDwemz+i+9mzUUBS394OuLrIyzIskNawZG6O862GZzWcJ4aIJ3GoU+TDpMlpPLnF4ZJBUaoOsYaS4HCmAELE=
X-Gm-Message-State: AOJu0YznNa4VZI8ALtNwqkw+JwYIlNmimJ3ViS52PELc+zHdp1yiJuA8
	ZOcUPeZT28lzuRXaun/ScXay2euB+ylxCMlukokaIZOcYJWSRlU=
X-Google-Smtp-Source: AGHT+IGoKwhar7NlMl2apZUwCOXmcqLKM6ZBxJnDLCv9X+cK9Yfd5D28VbDOZGaOKZdXxk5Hv9Qk2A==
X-Received: by 2002:a05:6830:700a:b0:709:396c:f295 with SMTP id 46e09a7af769-70c9da20784mr2698574a34.32.1723615106398;
        Tue, 13 Aug 2024 22:58:26 -0700 (PDT)
Received: from swift.. ([123.113.248.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c697a06d90sm2433129a12.43.2024.08.13.22.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 22:58:26 -0700 (PDT)
From: LidongLI <wirelessdonghack@gmail.com>
To: gregkh@linuxfoundation.org
Cc: kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	mark.esler@canonical.com,
	stf_xl@wp.pl,
	wirelessdonghack@gmail.com,
	tytso@mit.edu,
	stern@rowland.harvard.edu
Subject: Re: Ubuntu RT2X00 WIFI USB Driver Kernel NULL pointer Dereference&Use-After-Free Vulnerability
Date: Wed, 14 Aug 2024 13:58:16 +0800
Message-Id: <20240814055816.2786467-1-wirelessdonghack@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024080359-getaway-concave-623e@gregkh>
References: <2024080359-getaway-concave-623e@gregkh>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Dear 



When will the patch be released? We are waiting to test it.




Best regards


