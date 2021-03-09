Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6696332318
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Mar 2021 11:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhCIKdT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Mar 2021 05:33:19 -0500
Received: from mail1.protonmail.ch ([185.70.40.18]:33512 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhCIKdF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Mar 2021 05:33:05 -0500
Date:   Tue, 09 Mar 2021 10:32:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tmb.nu;
        s=protonmail; t=1615285981;
        bh=v1yaEUxC3sqt1vlV8fUDWRuFdt0sJJhvj9dGbjEBCLA=;
        h=Date:To:From:Reply-To:Subject:From;
        b=fVJQ8o3bkkMfDgFSetFdfQJwZWMovFncrZiWLbApkc2FLb9sWcP3vWJy6+7uVBLoO
         jym8MKswDb8sQylEA1lUXxE3L0E269pYhR7PL9fJx0BVIN8NSDjt9BH5r0DRsh13EG
         S3SnGaH9M+haRH/xreYyk6/0F8pwpilJ2tdyGOAE=
To:     luciano.coelho@intel.com, linux-wireless@vger.kernel.org
From:   Thomas Backlund <tmb@tmb.nu>
Reply-To: Thomas Backlund <tmb@tmb.nu>
Subject: Re: pull request: iwlwifi firmware updates 2021-03-05
Message-ID: <2663a3a4-1ef6-6837-ba30-5db988e331ea@tmb.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Den 5.3.2021 kl. 12:26, skrev Luca Coelho:
> Hi,
>
> This contains some new and updated firmwares for all our currently
> maintained FW binaries.
>
> Please pull or let me know if there are any issues.
>

Something not matching here...

filelist adds *-62.ucode

WHENCE adds *-59.ucode references

--
Thomas

> --
> Cheers,
> Luca.
>
>
> The following changes since commit 5ecd13ffe8e24385cf4f30f3d0dcaff4dfb24d=
e2:
>
>    Mellanox: Add new mlxsw_spectrum firmware xx.2008.2406 (2021-03-03 13:=
23:49 -0500)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-firmware=
.git iwlwifi-fw-2021-03-05
>
> for you to fetch changes up to 568016467deab716b8a382bf087209b781d4bca7:
>
>    iwlwifi: add new FWs from core59-66 release (2021-03-05 12:18:25 +0200=
)
>
> ----------------------------------------------------------------
> Update iwlwifi firmwares to Core59-66
>
> ----------------------------------------------------------------
> Luca Coelho (3):
>        iwlwifi: update 7265D firmware
>        iwlwifi: update 9000-family firmwares
>        iwlwifi: add new FWs from core59-66 release
>
>   WHENCE                            |  34 +++++++++++++++++++++++++++++++=
++-
>   iwlwifi-7265D-29.ucode            | Bin 1036444 -> 1036772 bytes
>   iwlwifi-9000-pu-b0-jf-b0-46.ucode | Bin 1512096 -> 1514240 bytes
>   iwlwifi-9260-th-b0-jf-b0-46.ucode | Bin 1483116 -> 1485556 bytes
>   iwlwifi-Qu-b0-hr-b0-62.ucode      | Bin 0 -> 1329296 bytes
>   iwlwifi-Qu-b0-jf-b0-62.ucode      | Bin 0 -> 1248672 bytes
>   iwlwifi-Qu-c0-hr-b0-62.ucode      | Bin 0 -> 1329312 bytes
>   iwlwifi-Qu-c0-jf-b0-62.ucode      | Bin 0 -> 1248688 bytes
>   iwlwifi-QuZ-a0-hr-b0-62.ucode     | Bin 0 -> 1328924 bytes
>   iwlwifi-QuZ-a0-jf-b0-62.ucode     | Bin 0 -> 1248672 bytes
>   iwlwifi-cc-a0-62.ucode            | Bin 0 -> 1292672 bytes
>   iwlwifi-ty-a0-gf-a0-62.ucode      | Bin 0 -> 1455104 bytes
>   iwlwifi-ty-a0-gf-a0.pnvm          | Bin 0 -> 27456 bytes
>   13 files changed, 33 insertions(+), 1 deletion(-)
>   create mode 100644 iwlwifi-Qu-b0-hr-b0-62.ucode
>   create mode 100644 iwlwifi-Qu-b0-jf-b0-62.ucode
>   create mode 100644 iwlwifi-Qu-c0-hr-b0-62.ucode
>   create mode 100644 iwlwifi-Qu-c0-jf-b0-62.ucode
>   create mode 100644 iwlwifi-QuZ-a0-hr-b0-62.ucode
>   create mode 100644 iwlwifi-QuZ-a0-jf-b0-62.ucode
>   create mode 100644 iwlwifi-cc-a0-62.ucode
>   create mode 100644 iwlwifi-ty-a0-gf-a0-62.ucode
>   create mode 100644 iwlwifi-ty-a0-gf-a0.pnvm
>


