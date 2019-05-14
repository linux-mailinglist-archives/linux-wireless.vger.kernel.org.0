Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 224B91C4FD
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 10:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfENIbN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 04:31:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39099 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfENIbN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 04:31:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id w8so15703045wrl.6
        for <linux-wireless@vger.kernel.org>; Tue, 14 May 2019 01:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=u6tl+Ifw5QQe79ZvuXQPkJ9D7TkExDuPgGsND9OkpAo=;
        b=ef4iPNpNhJt4nT/oY72Lq9mZ1T6CHfS2Epp2Z1i+i3BVNkZO4FExiiruTVLvisqEXC
         1sd2R0H/AB1/4FH0RNN5/I8Ikmgh79XtHUdj3Sx6gfx3XEpYqaOIpwNU9/egL+NlzAka
         o7x7Vj+Au/c/B37Z3YY7tXXd2V4Eb5RlhL5ehRMzEQCR+RrQ22pUbhOgaKGONIobKAoj
         reUrX4KmufrR9p0hqxwxOZF+DweNaFOweK+plr1ZNwj4Dn+kx5iejTDwYCxBu2r0EMSx
         aohYlw/63qzwxhZxGSXDInOEF/hr4ZIzJUSoY5rfwbSNGGc0kSFDybdyTgl2oKySCekK
         zcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=u6tl+Ifw5QQe79ZvuXQPkJ9D7TkExDuPgGsND9OkpAo=;
        b=FCu9vzEQZAN/cqBE0ss77LogvPTJfK48nZHGnsLRR3HEcapq4MFfB2ZWOfxIgfzFM0
         Cq/zJfZx8d91QL8VfzKjt/c4SXMxnJqRYzfdrCUwQ+1dH4pzpfYKc6INKCM/40VcOh9i
         fR4zCTKxGdX5fHBBE5xcd33yaLOfZPHk9Y940zv6tfLzthY7K8HH5/Mfh9pjhMKcpBhh
         ewAtaLDxOA90VOp/r5LtrPFvtjyZcwHNnUqkKuMDG5iQIVDjkdEgrJF/OROUOvtaKn+J
         5j8il+ggdIhmdfLR2v+BYi1uK3V9v/vDFndHa5W9erw6iv7wkhdObBS5JMmZO2Yyj/tv
         syOg==
X-Gm-Message-State: APjAAAUUzq+A29bOcBlhAlXiTZyF6V7I18JRPQQ+07iLcKfufkbHEVZu
        Zvu3LDXbUZpuNILgFDBZdH3+PC59/zQbZxT+/eQ=
X-Google-Smtp-Source: APXvYqxGwhc5aZI4+oS3BDbMXI+y/GcYiGI4n6TEunXE84FU5BFgY0JcI3NgF8V1cCAZhO36cBFNGnwpZYmSExDHY64=
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr21321753wrj.66.1557822671465;
 Tue, 14 May 2019 01:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <c2d0d19f-d814-8f41-4860-77b9cc7f9d26@linaro.org>
 <CA+icZUVz7sB6hv4fhL_rqhR_D8RePBJFXk1PaUy5tMw2z4xC_Q@mail.gmail.com>
 <5ae87449-83a1-ecce-c72c-b4742c507497@linaro.org> <CA+icZUXDLQKyTH-_pPi7A2=Bu5ratwab930Fcecrdr4NtMnFcw@mail.gmail.com>
 <27f2ce02-8deb-384f-af10-7737b703770a@linaro.org>
In-Reply-To: <27f2ce02-8deb-384f-af10-7737b703770a@linaro.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 May 2019 10:30:59 +0200
Message-ID: <CA+icZUVa_Sfcp-P=cLyH1VOpZ=pFmrLDG1Epebe9s7Qa9fghaA@mail.gmail.com>
Subject: Re: NXP NFC version and ACPI
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-nfc@lists.01.org,
        oleg.zhurakivskyy@intel.com, clement.perrochaud@effinnov.com,
        charles.gorand@effinnov.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 14, 2019 at 10:17 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 14/05/2019 09:49, Sedat Dilek wrote:
> > On Tue, May 14, 2019 at 8:43 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> > [...]
> >
> >> The nxp-nci kernel module is loaded and neard is installed.
> >
> > You have to...
> >
> > # modprobe -v nxp-nci_i2c
> >
> > # lsmod | egrep 'nfc|nci|nxp|i2c' | sort
> > i2c_algo_bit           16384  1 i915
> > i2c_dev                24576  0
> > i2c_i801               32768  0
> > nci                    77824  2 nxp_nci,nxp_nci_i2c
> > nfc                   131072  16 nci,nxp_nci
> > nxp_nci                16384  1 nxp_nci_i2c
> > nxp_nci_i2c            16384  0
> > rfkill                 28672  10 nfc,bluetooth,thinkpad_acpi,cfg80211
>
> I have the same modules except 'rfkill'
>
> > # modinfo nxp_nci_i2c
> > filename:
> > /lib/modules/5.1.1-1-amd64-iniza/kernel/drivers/nfc/nxp-nci/nxp-nci_i2c=
.ko
> > author:         Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
> > author:         Cl=C3=A9ment Perrochaud <clement.perrochaud@nxp.com>
> > description:    I2C driver for NXP NCI NFC controllers
> > license:        GPL
> > alias:          i2c:nxp-nci_i2c
> > alias:          acpi*:NXP7471:*
> > alias:          acpi*:NXP1001:*
> > alias:          of:N*T*Cnxp,nxp-nci-i2cC*
> > alias:          of:N*T*Cnxp,nxp-nci-i2c
> > depends:        nci,nxp-nci
> > retpoline:      Y
> > intree:         Y
> > name:           nxp_nci_i2c
> > vermagic:       5.1.1-1-amd64-iniza SMP mod_unload modversions
>
> Same result for the modinfo.
>
> -----
>
> So the first time I run:
>
> [mark]
> nfctool -d nfc0 -p
> Start polling on nfc0 as initiator
>
> With an error in syslog/dmesg:
> nci: nci_ntf_packet: unknown ntf opcode 0x0
>
>
> The second time:
>
> nfctool -p -d nfc0
> Protocol error
>
> With an error in syslog/dmesg:
> nci: nci_start_poll: failed to set local general bytes
>
> Then I do:
>
> nfctool -0 -d nfc0
>
> it returns to point [mark]
>

I cannot help with (debugging) nci.

I had all I2C and GPIO debug Kconfigs enabled to see a bit more
informations in the logs.
Maybe that helps you.

- Sedat -
