Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD6D7131A6B
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 22:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgAFVa1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 16:30:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbgAFVa1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 16:30:27 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89D9E21744
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jan 2020 21:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578346226;
        bh=zt2cipuUcBin5ZksuZK5p3CaS5gJFK69vb1I6cpfeUE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Dq7xNIa+QyOvm50nf0J9wAyeq/WZEkvMyZs1TNcG1bic4azKsEmyU81Mkkuku3Y5X
         S9wg3DJbZ+DDRBdNexjPzyZxnYXeAiNlKUsd1NNTmho6juw+79dSknLUS0N+MdVXTm
         51oQ3ocfo0BKDfcrukvW0rfiV2yFCqLpSy7COzFU=
Received: by mail-qt1-f172.google.com with SMTP id e12so43686523qto.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jan 2020 13:30:26 -0800 (PST)
X-Gm-Message-State: APjAAAVRERkqtW0/RWyVSeXlUiTUOVbAytTE5Y0CGGvunUmYmNN4cjOu
        HKhKzHoVTNjpbbz+eTJ/nUZQj5DDnZi89akka0w=
X-Google-Smtp-Source: APXvYqyMIwY8w2g53pXFhSO7MJ40xSVa8Sz2qpRNIT0nAvliecEeM6MaPvHs39uc+1XEvhenfVVyRxCt/ASI0C7NtZs=
X-Received: by 2002:ac8:30f7:: with SMTP id w52mr77707481qta.380.1578346225720;
 Mon, 06 Jan 2020 13:30:25 -0800 (PST)
MIME-Version: 1.0
References: <DB7PR04MB5242F3AB5904D80328C2E70E8F260@DB7PR04MB5242.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB5242F3AB5904D80328C2E70E8F260@DB7PR04MB5242.eurprd04.prod.outlook.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Mon, 6 Jan 2020 16:30:04 -0500
X-Gmail-Original-Message-ID: <CA+5PVA5GCJv2cp9Ff_U7H_YqpSSNgJ2cO3Weu_abAuxUjFgc_g@mail.gmail.com>
Message-ID: <CA+5PVA5GCJv2cp9Ff_U7H_YqpSSNgJ2cO3Weu_abAuxUjFgc_g@mail.gmail.com>
Subject: Re: pull-request mwifiex-firmware 2019-12-31
To:     Ganapathi Bhat <ganapathi.bhat@nxp.com>
Cc:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Cathy Luo <xiaohua.luo@nxp.com>,
        Rakesh Parmar <rakesh.parmar@nxp.com>,
        James Cao <james.cao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Dec 31, 2019 at 1:50 AM Ganapathi Bhat <ganapathi.bhat@nxp.com> wrote:
>
> The following changes since commit 6ae3652bbf4cc025afec3e15fc4bebc6fd29ee2b:
>
>   linux-firmware: update licence text for Marvell firmware (2019-06-08 12:13:25 +0530)
>
> are available in the git repository at:
>
>   https://github.com/NXP/mwifiex-firmware.git master
>
> for you to fetch changes up to e65245cc861d0ed57eaf79519af440d1e66b75d6:
>
>   linux-firmware: add NXP firmware licence file (2019-12-31 12:14:50 +0530)
>
> ----------------------------------------------------------------
> Ganapathi Bhat (1):
>       linux-firmware: add NXP firmware licence file
>
>  LICENCE.NXP | 22 ++++++++++++++++++++++
>  WHENCE      |  4 ++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
>  create mode 100644 LICENCE.NXP

Pulled and pushed out.

josh
