Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB6768EA83
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2019 13:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbfHOLm1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Aug 2019 07:42:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730874AbfHOLm1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Aug 2019 07:42:27 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 721432133F
        for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2019 11:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565869346;
        bh=SUc4wC49K7MXeJrC68ZWvkcXbzE3jYGplf44JQONEYc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oxdSgHeBnuFd2W46Ki6Iq1O79GK64L+EL4ULqgyg1Az4HvBMVzgW2aYq5JoLwx5tQ
         dGHHy12BF2qk23+mVDtjaUxYTm95o2sb52RoINNEcZnrZnBEBaoTNIBRgG9q6yO0yF
         MVN0htklK9+vBcL+/BJByIlV3jyN7bs8G354n7OE=
Received: by mail-qt1-f173.google.com with SMTP id y26so1986477qto.4
        for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2019 04:42:26 -0700 (PDT)
X-Gm-Message-State: APjAAAXaM80Ks8rPHXokI2hj/Sboesv7H/WOwPfZK6KteOyyOGe1OaiL
        OJjJzsHpwmlgwOopdrM05eYb1JRQoQg3iV4keQU=
X-Google-Smtp-Source: APXvYqzklUHEdg1ndGaAmJjlnoTZp7ttyUVGKmEwutoj1u00wYxgX2Fr9zu9p9laY57LNF0MNSL7ou93gOzoxxd7JVc=
X-Received: by 2002:ac8:95d:: with SMTP id z29mr3525067qth.380.1565869345626;
 Thu, 15 Aug 2019 04:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <1565252549-25524-1-git-send-email-yhchuang@realtek.com>
In-Reply-To: <1565252549-25524-1-git-send-email-yhchuang@realtek.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Thu, 15 Aug 2019 07:42:14 -0400
X-Gmail-Original-Message-ID: <CA+5PVA4rM1u4C-c-_efonrYgX6vFaCAt0kfJnAq7Tc33HRWRUA@mail.gmail.com>
Message-ID: <CA+5PVA4rM1u4C-c-_efonrYgX6vFaCAt0kfJnAq7Tc33HRWRUA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] rtw88: update 8822c firmware files
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Linux Firmware <linux-firmware@kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Brian Norris <briannorris@chromium.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 8, 2019 at 4:22 AM <yhchuang@realtek.com> wrote:
>
> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> Update 8822c firmware image, and add wowlan firmware.
> Also add a README to describe its usage.
>
> Yan-Hsuan Chuang (3):
>   rtw88: RTL8822C: update rtw8822c_fw.bin to v7.3
>   rtw88: RTL8822C: add WoW firmware v7.3
>   rtw88: add a README file
>
>  WHENCE                    |   1 +
>  rtw88/README              |  28 ++++++++++++++++++++++++++++
>  rtw88/rtw8822c_fw.bin     | Bin 184640 -> 189152 bytes
>  rtw88/rtw8822c_wow_fw.bin | Bin 0 -> 138720 bytes
>  4 files changed, 29 insertions(+)
>  create mode 100644 rtw88/README
>  create mode 100755 rtw88/rtw8822c_wow_fw.bin

All three applied and pushed out.  I edited the third patch to add the
README to WHENCE.

josh
