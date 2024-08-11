Return-Path: <linux-wireless+bounces-11270-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3782894E270
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 19:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36612818C1
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 17:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EB927457;
	Sun, 11 Aug 2024 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jr5eHBy2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B7C27447
	for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723397468; cv=none; b=NRwlE3ljKlv61UBLeGlK5oE5mmQIryCgQKAq9WWCf0iX+P2F3y1VI3yiyuMfpRPLb+qX0vv9wfZ7M7rPqqQUIZlDWOQezasfv1ef41X2FdKZDmxbi9piGmR9/FZgblZj1JtA//15dHQTOOjqH5Vz/CMiA33IZ0qsvE09otZHZzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723397468; c=relaxed/simple;
	bh=3oYIfin0PEE+fHRc99To4AiacyuocVX4Dn1rgUOhJBY=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:References:To:
	 Date; b=YmEV1jWWWL7X2Pc2+8REnRekd7gw9a2Af+FwGqv02sxP0Newts9aX99cmVOPt9zAAgzkg6PCuqOXaxUATW0NUmkKXSd+EtVrf9swb+1bflWRYpbye9DohxQtQ+yTjl3H8xdKKFHgr/uN//csDxcsTAD7RbnEzfcjfyt54zZbiiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jr5eHBy2; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso56276521fa.2
        for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 10:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723397465; x=1724002265; darn=vger.kernel.org;
        h=date:to:references:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3oYIfin0PEE+fHRc99To4AiacyuocVX4Dn1rgUOhJBY=;
        b=Jr5eHBy2ndbKWYEGYuStZox8/uj9E/Cf2Je3b4nJwudV2Qp96bgFPPUmbW7t39NKLO
         Z3VzqBkaSxuBW4/7BQefYRALqfVgFPSY1CltC37ItFg6MMvfOVaKGp8+BWX7leep4ZTp
         qN82k8ZtlFb12w98oLcJDGYSfc9njoR8ytPEXk0wEkYKBTDD3PG2z35UvXDug5Bw6Wiu
         LBNGG+sMXl1CuYbdOB9SRIHUpSWGh5QxTTb8zQp5dppXubP6jPTp9ROYSmmOXxXIiwTy
         wmVCGkup+rEL1OrencMqHl14MI9X7GUywyJT/KODGA7z+kWWCwYTaLxmulQuLscJvvTv
         /WmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723397465; x=1724002265;
        h=date:to:references:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oYIfin0PEE+fHRc99To4AiacyuocVX4Dn1rgUOhJBY=;
        b=uesTsfO6dFXTiJb0KcYghRXfdiQPoAAb8NzsErAWb4LywHPKKqMaikytYfHh9fRZU3
         42bY0/8b1nOqLx1sD5apMiOD4e8mddSmvXUGlB2b1WYKxFZEN6Pv7XK46LdBMJwgO2hX
         2WqJoojK5DO+KpuwZYUUtLSpwlKEP03m50NUUIizG4HcNxgkNyrlyTp0c55oQisZ/Nzq
         2DqjY0kFPU2PSe29p+t75s/Fi4KBnFnMwL0jfIW1TYJcvFORbcxcgLftnAo+oOxwiS96
         vGG9xpkBM9NnpZ3/SnejcK6fM0TVp6yJd+ELet8G7kNKHsVoUagVEujTG14NRU6X7HS+
         vRXg==
X-Gm-Message-State: AOJu0YwMT+wDfg3hJw7vIUvN1lGyQ2bmvyNyVsdQ6taj/r74LhBh9onJ
	A5XC0nQaJArnouM9BC56xYNu0uJMMD/hsppmnGRyPuSSsxglnCGcW7dLXkYzs3g=
X-Google-Smtp-Source: AGHT+IG/dyHBp8cObQ2ll/4VmSDGJy7B2vyKU/PohkblR0P2pUdeHG1CmyfC98lc1Z09BzUNfTqqeg==
X-Received: by 2002:a2e:d09:0:b0:2ef:29cd:3191 with SMTP id 38308e7fff4ca-2f1a6cdcf30mr58911941fa.35.1723397464352;
        Sun, 11 Aug 2024 10:31:04 -0700 (PDT)
Received: from smtpclient.apple ([169.224.80.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb212bd2sm162814666b.176.2024.08.11.10.31.03
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2024 10:31:03 -0700 (PDT)
From: MOHAMMAD RASIM <mohammad.rasim96@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: [question] is it possible to enable monitor mode /packet injection on
 wcn3990
Message-Id: <56BBE89F-FF40-47C4-A4B9-F492FD8F6E2A@gmail.com>
References: <CACq04CG8WCGDxf6Krx3bjxHU5OtYJJNOtD77TtPQhTfdy6ey_g@mail.gmail.com>
To: linux-wireless@vger.kernel.org
Date: Sun, 11 Aug 2024 20:30:51 +0300
X-Mailer: Apple Mail (2.3774.600.62)

Hi,
I have a device that has the wcn3990 wifi chip that uses the ath10k_snoc =
driver, i tried to put it in monitor mode, the "set monitor" mode =
command succeed but can't get any scanning working after that, does the =
chip support such mode?has anyone tried monitor mode with this chip or =
other snoc chips?

Regards=

