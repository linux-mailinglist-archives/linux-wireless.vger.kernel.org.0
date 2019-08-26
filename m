Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B96509D100
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2019 15:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbfHZNsI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Aug 2019 09:48:08 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:37082 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfHZNsI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Aug 2019 09:48:08 -0400
Received: from bentobox.localnet (p200300C5970CB6F80000000000000699.dip0.t-ipconnect.de [IPv6:2003:c5:970c:b6f8::699])
        by dvalin.narfation.org (Postfix) with ESMTPSA id 48B061FE75;
        Mon, 26 Aug 2019 13:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1566827283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UzOXWYaqad32QXBAmtszP5EUVKl3fPXSUq2j9ipqBQ8=;
        b=J6+PGDuwaFtgfJYrGjAkOtdPt4WqFrouFD8rJGAvNXR1Wym1qYJfOCNN6dnOrCwQqzU2vC
        pwxEIshCju8cFiOrpyLGn8UF363PPQ+1DXkzgYRQ+k2BQcVEX6y+QOKK8JOt3D4w8z/XiD
        uxH4C3/PkZwNL+KKBfJGn8U8xWKQwYk=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 10/49] ath11k: add debug.c
Date:   Mon, 26 Aug 2019 15:47:57 +0200
Message-ID: <2708501.D2hezO5Rnt@bentobox>
In-Reply-To: <1566316095-27507-11-git-send-email-kvalo@codeaurora.org>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org> <1566316095-27507-11-git-send-email-kvalo@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3959043.Os2YI8mG4J"; micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1566827283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UzOXWYaqad32QXBAmtszP5EUVKl3fPXSUq2j9ipqBQ8=;
        b=jnk0cQm8NqsMqi3gCItpeRfc7fV+Eutt4grxajDEQ1pH825wuay5caxSkVnNXgwVwpwG8h
        aJesF+E6R+qikmVaP/1VaM2+QWzkfsyJGOfAEWX4NfvOC4FIfXI4F/P46DnibzkiTFpmDR
        hjc1i9iyhy8WNoZrWbNgF8mKZ2xg7Hg=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1566827283; a=rsa-sha256;
        cv=none;
        b=dcQB79EqPD4WvyRx7UTLyzayqggSLEKx4VbBs+cRQFR/nhl3pyV68XTlOy9Z24hD6ScohS
        hGq5dCvahnBHXxrzFEoikuUPVL4htrmv6W9sEDg1np6bFctuWCtWBaybtKmghlP7pdFILY
        lUnlKRevc9y8Fxsqotu+W3SOy8YeyNU=
ARC-Authentication-Results: i=1;
        dvalin.narfation.org;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart3959043.Os2YI8mG4J
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 20 August 2019 17:47:36 CEST Kalle Valo wrote:
> +static ssize_t ath11k_read_simulate_fw_crash(struct file *file,
> +                                            char __user *user_buf,
> +                                            size_t count, loff_t *ppos)
> +{
> +       const char buf[] =
> +               "To simulate firmware crash write one of the keywords to this file:\n"
> +               "`assert` - this will send WMI_FORCE_FW_HANG_CMDID to firmware to cause assert.\n"
> +               "`hw-restart` - this will simply queue hw restart without fw/hw actually crashing.\n";
> +
> +       return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
> +}

There is nothing in the write handler which handles "hw-restart". It just 
causes an -EINVAL.

> +
> +/* Simulate firmware crash:
> + * 'soft': Call wmi command causing firmware hang. This firmware hang is
> + * recoverable by warm firmware reset.
> + * 'hard': Force firmware crash by setting any vdev parameter for not allowed
> + * vdev id. This is hard firmware crash because it is recoverable only by cold
> + * firmware reset.
> + */
> +static ssize_t ath11k_write_simulate_fw_crash(struct file *file,
> +                                             const char __user *user_buf,
> +                                             size_t count, loff_t *ppos)
> +{
> +       struct ath11k_base *ab = file->private_data;
> +       struct ath11k_pdev *pdev;
> +       struct ath11k *ar = ab->pdevs[0].ar;
> +       char buf[32] = {0};
> +       ssize_t rc;
> +       int i, ret, radioup;
> +
> +       for (i = 0; i < ab->num_radios; i++) {
> +               pdev = &ab->pdevs[i];
> +               ar = pdev->ar;
> +               if (ar && ar->state == ATH11K_STATE_ON) {
> +                       radioup = 1;
> +                       break;
> +               }
> +       }
> +       /* filter partial writes and invalid commands */
> +       if (*ppos != 0 || count >= sizeof(buf) || count == 0)
> +               return -EINVAL;
> +
> +       rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, user_buf, count);
> +       if (rc < 0)
> +               return rc;
> +
> +       /* drop the possible '\n' from the end */
> +       if (buf[*ppos - 1] == '\n')
> +               buf[*ppos - 1] = '\0';
> +
> +       if (radioup == 0) {
> +               ret = -ENETDOWN;
> +               goto exit;
> +       }
> +
> +       if (!strcmp(buf, "assert")) {
> +               ath11k_info(ab, "simulating firmware assert crash\n");
> +               ret = ath11k_wmi_force_fw_hang_cmd(ar,
> +                                                  ATH11K_WMI_FW_HANG_ASSERT_TYPE,
> +                                                  ATH11K_WMI_FW_HANG_DELAY);
> +       } else {
> +               ret = -EINVAL;
> +               goto exit;
> +       }
> +
> +       if (ret) {
> +               ath11k_warn(ab, "failed to simulate firmware crash: %d\n", ret);
> +               goto exit;
> +       }
> +
> +       ret = count;
> +
> +exit:
> +       return ret;
> +}

And right now, the write of an "assert" to this file just causes an fatal error for the system:

    [ 4312.409255] qcom-q6v5-wcss-pil cd00000.qcom_q6v5_wcss: fatal error received:
    [ 4312.409255] QC Image Version: QC_IMAGE_VERSION_STRING=WLAN.HK.2.1.0.1-00410-QCAHKSWPL_SILICONZ-2
    [ 4312.409255] Image Variant : IMAGE_VARIANT_STRING=8074.wlanfw.eval_v2Q
    [ 4312.409255] 
    [ 4312.409255] wlan_wmi.c:234 Assertion 0 failedparam0 :zero, param1 :zero, param2 :zero.
    [ 4312.409255] Thread ID      : 0x00000069  Thread name    : WLAN RT0  Process ID     : 0
    [ 4312.409255] Register:
    [ 4312.409255] SP : 0x4c168d58
    [ 4312.409255] FP : 0x4c168d60
    [ 4312.409255] PC : 0x4b1c8850
    [ 4312.409255] SSR : 0x00000008
    [ 4312.409255] BADVA : 0x00020000
    [ 4312.409255] LR : 0x4b1c7c68
    [ 4312.409255] 
    [ 4312.409255] Stack Dump
    [ 4312.409255] from : 0x4c168d58
    [ 4312.409255] to   : 0x4c168f00
    [ 4312.409255] 
    [ 4312.455997] remoteproc remoteproc0: crash detected in cd00000.qcom_q6v5_wcss: type fatal error
    [ 4312.478259] remoteproc remoteproc0: handling crash #1 in cd00000.qcom_q6v5_wcss
    [ 4312.486826] Kernel panic - not syncing: remoteproc remoteproc0: Resetting the SoC - cd00000.qcom_q6v5_wcss crashed
    [ 4312.494028] CPU: 2 PID: 5590 Comm: kworker/2:0 Tainted: G        W       4.4.60 #0
    [ 4312.504436] Hardware name: Generic DT based system
    [ 4312.511991] Workqueue: events rproc_crash_handler_work
    [ 4312.521880] [<8021e86c>] (unwind_backtrace) from [<8021b404>] (show_stack+0x10/0x14)
    [ 4312.521979] [<8021b404>] (show_stack) from [<803dd818>] (dump_stack+0x7c/0x9c)
    [ 4312.529789] [<803dd818>] (dump_stack) from [<80225d80>] (panic+0x84/0x1f8)
    [ 4312.536818] [<80225d80>] (panic) from [<80555278>] (rproc_crash_handler_work+0x90/0x98)
    [ 4312.543678] [<80555278>] (rproc_crash_handler_work) from [<802380e8>] (process_one_work+0x1c0/0x2f8)
    [ 4312.551578] [<802380e8>] (process_one_work) from [<80238d24>] (worker_thread+0x2b0/0x3ec)
    [ 4312.560952] [<80238d24>] (worker_thread) from [<8023cf84>] (kthread+0xd8/0xec)
    [ 4312.569023] [<8023cf84>] (kthread) from [<80209be8>] (ret_from_fork+0x14/0x2c)
    [ 4312.576141] CPU0: stopping
    [ 4312.583335] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W       4.4.60 #0
    [ 4312.586032] Hardware name: Generic DT based system
    [ 4312.593237] [<8021e86c>] (unwind_backtrace) from [<8021b404>] (show_stack+0x10/0x14)
    [ 4312.597930] [<8021b404>] (show_stack) from [<803dd818>] (dump_stack+0x7c/0x9c)
    [ 4312.605827] [<803dd818>] (dump_stack) from [<8021dc3c>] (handle_IPI+0xe8/0x180)
    [ 4312.612858] [<8021dc3c>] (handle_IPI) from [<802093a4>] (gic_handle_irq+0x78/0x94)
    [ 4312.620063] [<802093a4>] (gic_handle_irq) from [<8020a480>] (__irq_svc+0x40/0x74)
    [ 4312.627701] Exception stack(0x80c67f60 to 0x80c67fa8)
    [ 4312.635249] 7f60: 00000001 00000000 00000000 8020b320 00000000 80c66000 00000000 80c612cc
    [ 4312.640291] 7f80: 80c67fb8 808f3a30 80cae010 00000000 00000000 80c67fb0 80218edc 80218ee0
    [ 4312.648448] 7fa0: 60000013 ffffffff
    [ 4312.656601] [<8020a480>] (__irq_svc) from [<80218ee0>] (arch_cpu_idle+0x2c/0x50)
    [ 4312.659909] [<80218ee0>] (arch_cpu_idle) from [<80254b38>] (cpu_startup_entry+0x134/0x214)
    [ 4312.667553] [<80254b38>] (cpu_startup_entry) from [<808cac48>] (start_kernel+0x380/0x404)
    [ 4312.675620] CPU1: stopping
    [ 4312.683855] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W       4.4.60 #0
    [ 4312.686466] Hardware name: Generic DT based system
    [ 4312.693671] [<8021e86c>] (unwind_backtrace) from [<8021b404>] (show_stack+0x10/0x14)
    [ 4312.698363] [<8021b404>] (show_stack) from [<803dd818>] (dump_stack+0x7c/0x9c)
    [ 4312.706263] [<803dd818>] (dump_stack) from [<8021dc3c>] (handle_IPI+0xe8/0x180)
    [ 4312.713293] [<8021dc3c>] (handle_IPI) from [<802093a4>] (gic_handle_irq+0x78/0x94)
    [ 4312.720497] [<802093a4>] (gic_handle_irq) from [<8020a480>] (__irq_svc+0x40/0x74)
    [ 4312.728135] Exception stack(0xbe083f98 to 0xbe083fe0)
    [ 4312.735683] 3f80:                                                       00000001 00000000
    [ 4312.740725] 3fa0: 00000000 8020b320 00000000 be082000 00000000 80c612cc be083ff0 410fd034
    [ 4312.748884] 3fc0: 00000000 00000000 00000000 be083fe8 80218edc 80218ee0 60000013 ffffffff
    [ 4312.757045] [<8020a480>] (__irq_svc) from [<80218ee0>] (arch_cpu_idle+0x2c/0x50)
    [ 4312.765203] [<80218ee0>] (arch_cpu_idle) from [<80254b38>] (cpu_startup_entry+0x134/0x214)
    [ 4312.772669] [<80254b38>] (cpu_startup_entry) from [<4120944c>] (0x4120944c)
    [ 4312.780737] CPU3: stopping
    [ 4312.787589] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G        W       4.4.60 #0
    [ 4312.790372] Hardware name: Generic DT based system
    [ 4312.797577] [<8021e86c>] (unwind_backtrace) from [<8021b404>] (show_stack+0x10/0x14)
    [ 4312.802270] [<8021b404>] (show_stack) from [<803dd818>] (dump_stack+0x7c/0x9c)
    [ 4312.810167] [<803dd818>] (dump_stack) from [<8021dc3c>] (handle_IPI+0xe8/0x180)
    [ 4312.817199] [<8021dc3c>] (handle_IPI) from [<802093a4>] (gic_handle_irq+0x78/0x94)
    [ 4312.824403] [<802093a4>] (gic_handle_irq) from [<8020a480>] (__irq_svc+0x40/0x74)
    [ 4312.832041] Exception stack(0xbe087f98 to 0xbe087fe0)
    [ 4312.839588] 7f80:                                                       00000001 00000000
    [ 4312.844630] 7fa0: 00000000 8020b320 00000000 be086000 00000000 80c612cc be087ff0 410fd034
    [ 4312.852791] 7fc0: 00000000 00000000 00000000 be087fe8 80218edc 80218ee0 60000013 ffffffff
    [ 4312.860951] [<8020a480>] (__irq_svc) from [<80218ee0>] (arch_cpu_idle+0x2c/0x50)
    [ 4312.869109] [<80218ee0>] (arch_cpu_idle) from [<80254b38>] (cpu_startup_entry+0x134/0x214)
    [ 4312.876576] [<80254b38>] (cpu_startup_entry) from [<4120944c>] (0x4120944c)
    [ 4312.884650] The reading for sensor 4 is 0x002041f7
    [ 4312.891499] The reading for sensor 5 is 0x002051f4
    [ 4312.896415] Couldn't get reading for sensor 6
    [ 4312.901189] Couldn't get reading for sensor 7
    [ 4312.905561] The reading for sensor 8 is 0x002081e0
    [ 4312.909902] The reading for sensor 9 is 0x002091f7
    [ 4312.914645] Couldn't get reading for sensor 10
    [ 4312.919364] The reading for sensor 11 is 0x0020b1fa
    [ 4312.923791] The reading for sensor 12 is 0x0020c1fa
    [ 4312.928621] Couldn't get reading for sensor 13
    [ 4312.933425] The reading for sensor 14 is 0x0020e1f4
    [ 4312.937941] The reading for sensor 15 is 0x0020f1e7
    [ 4313.942700] Rebooting in 3 seconds..

Maybe can be fixed by a different kernel (for the remoteproc). But I don't 
have this kernel at the moment.


Kind regards,
	Sven
--nextPart3959043.Os2YI8mG4J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl1j4w0ACgkQXYcKB8Em
e0ZVBRAAlcj3GncLg9QhAmWQ7iOXsQEOohUBZkAavzK/HL+g43TNCMUyOx12gTkC
aqaSs9uZpQu5wrcPOih4AYF/ZnECHd3y0FVGoUxamgT/ZEw3430Q6pZtU9SayT2h
Tle88xGTtPG94/HgE1bdAvjh6hA5ThNihWwA/6eVPSsQ0JGrXPyI9xaqGqeC0X8W
vH9FHmR6ByjiHuxlXP5HUtDRR+H8ieMdHWOAJBxn1Jv1/dq+gjEVoUtUq3e9UF6N
A/8tFeHcXTJ5LpZyixxEY3llkqSqaTVQvKqNE1erDUZ8qMaEmgmI5HEnLg+R/VDD
dJviRmgCov+gCXnof+7m/spOE+6s+6mHfYRe3hhJltDtcjmLNjxdph8hvo066xMj
avOJDeDaWfljjHrkuTnl4RkJX/I20uUcuzlkcAhs1v3It+THoCLvwnwKnau384B2
ED3NVMX73ymp1Byo1uPzki2yoD0q/p0SqMU69zZ1iGexzIkxcQD1SUo5X1jL2Gfd
GYfXOqz/gbYnMliTweAljlmFWc/4wRRqA/DlrAWQJanzio4LS1duwNrMJAd5qC22
mFOfVuGQZ1tiMOp6EgnLYbvO2IRIWwo5eeA5dWXN+8TNl+lP7l8gcjJzNKgiPSVR
QmRJMhAul6rahQB551JMhogZrp6a2rTbi9OraqrWf+p1wy/qLDY=
=H8sw
-----END PGP SIGNATURE-----

--nextPart3959043.Os2YI8mG4J--



