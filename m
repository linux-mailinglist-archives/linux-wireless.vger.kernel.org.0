Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D796A48584
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2019 16:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfFQOdu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jun 2019 10:33:50 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59044 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQOdu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jun 2019 10:33:50 -0400
Received: from marcel-macpro.fritz.box (p4FEFC3D2.dip0.t-ipconnect.de [79.239.195.210])
        by mail.holtmann.org (Postfix) with ESMTPSA id A72B3CEE16;
        Mon, 17 Jun 2019 16:42:15 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: wpa_supplicant 2.8 fails in brcmf_cfg80211_set_pmk
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <605ea0a8-3303-b810-6223-18ccc7eb7af4@cypress.com>
Date:   Mon, 17 Jun 2019 16:33:48 +0200
Cc:     Stefan Wahren <wahrenst@gmx.net>,
        Stanley Hsu <Stanley.Hsu@cypress.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <Wright.Feng@cypress.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <2AF2E0A7-23F0-4FFE-A658-4906FF546199@holtmann.org>
References: <06f7bda7-eeaf-536b-a583-7c9bc5f681f5@gmx.net>
 <9da02861-9151-9700-2c09-b312d74155fa@gmx.net>
 <605ea0a8-3303-b810-6223-18ccc7eb7af4@cypress.com>
To:     Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Chi-hsien,

>>> i was able to reproduce an (maybe older issue) with 4-way handshake
>>> offloading for 802.1X in the brcmfmac driver. My setup consists of
>>> Raspberry Pi 3 B (current linux-next, arm64/defconfig) on STA side and a
>>> Raspberry Pi 3 A+ (Linux 4.19) on AP side.
>> 
>> Looks like Raspberry Pi isn't the only affected platform [3], [4].
>> 
>> [3] - https://bugzilla.redhat.com/show_bug.cgi?id=1665608
>> [4] - https://bugzilla.kernel.org/show_bug.cgi?id=202521
> 
> Stefan,
> 
> Could you please try the attached patch for your wpa_supplicant? We'll 
> upstream if it works for you.

I hope that someone is also providing a kernel patch to fix the issue. Hacking around a kernel issue in userspace is not enough. Fix the root cause in the kernel.

Regards

Marcel

