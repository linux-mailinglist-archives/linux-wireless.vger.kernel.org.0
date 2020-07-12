Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C828721C95F
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2020 15:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgGLNR6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Jul 2020 09:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbgGLNR5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Jul 2020 09:17:57 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AF1C061794
        for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2020 06:17:57 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l2so10358017wmf.0
        for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2020 06:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WiO8m3reEtbAs5WwDH/QNK8BneK0/E/6I2Kwl4JBBIs=;
        b=uZLm5AvIVRwpxw+cp8/zvoVWOktrXae6KdK+ZXEbiLsZ30+Ik0lXcSiu5F8dx4k+h4
         LI5XDDpHdGtJbCn2lNrzhUPgTLNOxj58VFxAxJ3OHT4eWvYy20TCLg8Oo5kNmtZhL6EW
         96deVk9UvHpbLNQQ5bAWlP57H83QcghhKPDMxkqP65dSkNJMEkpy37/Dp90W/sEPScBM
         TKYXpnXGoknGAn5TBcrLhJvAOBx3+1iVlwMTX7J71AzRCbeYbzkPH89p6rjo8iceREXL
         2Ze0rtCdxUfRQBKt/tPpmHa1iueFnG/H0lcHQZQrEHKaK3MBTxt5qAFDcvLqIOpC6DjD
         aiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WiO8m3reEtbAs5WwDH/QNK8BneK0/E/6I2Kwl4JBBIs=;
        b=U8UQOw3qbJGtWAS1BPU0Zdq3VC27ctwCNHYYpve4n8hSsV0kSH2lU46UNb9LHUxwFP
         S87REFJSe43pDKeDK4BFrw+HstpEnv8adIcS8QQZQqunjfmzMY5bw53Nb+u5+7E0x8qP
         q8ueFitde7F8v+BQ33Vi/nZrCSQk3C6ToL70W9wUgdVF039gyNSPFPuGftr3QxnlZqwn
         nV8tRbhc2nyIf3G4f89jmj0Z/a24cC4N3r8kAmz61eStKaOVjbbNNZkO7qBIwJ9uSJc4
         YhYQRApNPqCC8c1aBJDUKV6GapGBb/LYzApTJnY+PtBWWluMHCUCgj09oPVOoTLzrQcU
         ZFRg==
X-Gm-Message-State: AOAM531kC63961qz/Hp+iLb69t5J035vwqIgF+GHsw/wkJdK9rJCINrT
        or//8F9t8SUzSh9msPm/AaHPV1lj0o0MOcSkwLK38FlQo6A=
X-Google-Smtp-Source: ABdhPJw/CY9VZSsG+YSSST6qZ0iWTx0+N+6q0ooeD+/oI55OjJzNRkd4CjjO6yGdFKyJK0O7ApDyxQG1JMVwjWZzsq4=
X-Received: by 2002:a1c:f609:: with SMTP id w9mr14386923wmc.150.1594559875341;
 Sun, 12 Jul 2020 06:17:55 -0700 (PDT)
MIME-Version: 1.0
From:   Tony Thuitai <thuitaitony@gmail.com>
Date:   Sun, 12 Jul 2020 16:17:44 +0300
Message-ID: <CAHgcA=v0NyqEA1tc5WvgpXOS3MAX_10uBtWZVi3be+8s_6ygPg@mail.gmail.com>
Subject: 
To:     linux-wireless@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f1da4e05aa3e6673"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000f1da4e05aa3e6673
Content-Type: text/plain; charset="UTF-8"

Linux Distro: Linux Mint 20 Cinnamon
PC: HP Notebook 15-bs1xx

Network Devices:
Realtek RTL8111/8168/8411 PCI Express Gigabit Ethernet driver: r8169
Device-2: Realtek RTL8723DE 802.11b/g/n PCIe Adapter driver: rtw_pci
Device-3: Realtek 802.11n WLAN Adapter type: USB driver: btusb

I suspect snapd to be the cause of the errors. The errors also occur
when using rtw_8723de driver from lwfinger's rtw88 (lwfinger's
rtlwifi_new discontinued and rtw88 branch moved to lwfinger's rtw88
repo) GitHub repo. When installing snapd for the first time and when
snapd is still installed: updating network related packages, changing
a setting in a network related configuration file, disabling bluetooth
via systemd and creating a startup script/command via Startup
applications in Cinnamon desktop and rebooting to confirm the changes
cause the driver to fail and become unavailable. The errors that are
logged every time the driver fails are in the attached 'driver fail 1'
file and in 'driver fail 2' file contains some errors that have
occurred at least once when the driver fails. In the 'driver working
with error' log contains an error that is repeated which seems to be a
firmware issue

--000000000000f1da4e05aa3e6673
Content-Type: application/octet-stream; name=driver fail 1
Content-Disposition: attachment; filename=driver fail 1
Content-Transfer-Encoding: base64
Content-ID: <f_kcj3rmu00>
X-Attachment-Id: f_kcj3rmu00

MTI6NDg6MTIgd3BhX3N1cHBsaWNhbnQ6IHdsbzE6IEZhaWxlZCB0byBpbml0aWFsaXplIGRyaXZl
ciBpbnRlcmZhY2UKMTI6NDg6MTIga2VybmVsOiBydHdfcGNpIDAwMDA6MGQ6MDAuMDogZmFpbGVk
IHRvIHBvd2VyIG9uIG1hYwoxMjo0ODoxMiBOZXR3b3JrTWFuYWdlcjogPGVycm9yPiBbMTU5NDU0
NzI5Mi42ODQ5XSBzdXAtaWZhY2VbMHg1NWFlNGJjZDczZDAsd2xvMV06IGVycm9yIGFkZGluZyBp
bnRlcmZhY2U6IHdwYV9zdXBwbGljYW50IGNvdWxkbid0IGdyYWIgdGhpcyBpbnRlcmZhY2UuCjEy
OjQ4OjEyIHdwYV9zdXBwbGljYW50OiBDb3VsZCBub3Qgc2V0IGludGVyZmFjZSB3bG8xIGZsYWdz
IChVUCk6IEludmFsaWQgYXJndW1lbnQKMTI6NDg6MDYga2VybmVsOiBydHdfcGNpIDAwMDA6MGQ6
MDAuMDogZmFpbGVkIHRvIHBvd2VyIG9uIG1hYwoxMjo0ODowNiB3cGFfc3VwcGxpY2FudDogbmw4
MDIxMTogQ291bGQgbm90IHNldCBpbnRlcmZhY2UgJ3dsbzEnIFVQCjEyOjQ3OjUwIGtlcm5lbDog
cnR3X3BjaSAwMDAwOjBkOjAwLjA6IGZhaWxlZCB0byBwb3dlciBvbiBtYWMKMTI6NDc6NTAgd3Bh
X3N1cHBsaWNhbnQ6IHdsbzE6IEZhaWxlZCB0byBpbml0aWFsaXplIGRyaXZlciBpbnRlcmZhY2UK
MTI6NDc6NTAgTmV0d29ya01hbmFnZXI6IDxlcnJvcj4gWzE1OTQ1NDcyNzAuNzAwNl0gc3VwLWlm
YWNlWzB4NTVhZTRiY2Q3MmUwLHdsbzFdOiBlcnJvciBhZGRpbmcgaW50ZXJmYWNlOiB3cGFfc3Vw
cGxpY2FudCBjb3VsZG4ndCBncmFiIHRoaXMgaW50ZXJmYWNlLgoxMjo0Nzo1MCB3cGFfc3VwcGxp
Y2FudDogV0VYVDogQ291bGQgbm90IHNldCBpbnRlcmZhY2UgJ3dsbzEnIFVQCjEyOjQ3OjQ0IGtl
cm5lbDogcnR3X3BjaSAwMDAwOjBkOjAwLjA6IGZhaWxlZCB0byBwb3dlciBvbiBtYWMKMTI6NDc6
NDQgd3BhX3N1cHBsaWNhbnQ6IG5sODAyMTE6IENvdWxkIG5vdCBzZXQgaW50ZXJmYWNlICd3bG8x
JyBVUAoxMjo0NzoyOCBrZXJuZWw6IHJ0d19wY2kgMDAwMDowZDowMC4wOiBmYWlsZWQgdG8gcG93
ZXIgb24gbWFjCjEyOjQ3OjI4IHdwYV9zdXBwbGljYW50OiB3bG8xOiBGYWlsZWQgdG8gaW5pdGlh
bGl6ZSBkcml2ZXIgaW50ZXJmYWNlCjEyOjQ3OjI4IE5ldHdvcmtNYW5hZ2VyOiA8ZXJyb3I+IFsx
NTk0NTQ3MjQ4LjcyODhdIHN1cC1pZmFjZVsweDU1YWU0YmNkNzFmMCx3bG8xXTogZXJyb3IgYWRk
aW5nIGludGVyZmFjZTogd3BhX3N1cHBsaWNhbnQgY291bGRuJ3QgZ3JhYiB0aGlzIGludGVyZmFj
ZS4KMTI6NDc6Mjggd3BhX3N1cHBsaWNhbnQ6IFdFWFQ6IENvdWxkIG5vdCBzZXQgaW50ZXJmYWNl
ICd3bG8xJyBVUAoxMjo0NzoyMiBwdWxzZWF1ZGlvOiAgIGh3X3B0ciAgICAgICA6IDQyNjY4OAox
Mjo0NzoyMiB3cGFfc3VwcGxpY2FudDogbmw4MDIxMTogQ291bGQgbm90IHNldCBpbnRlcmZhY2Ug
J3dsbzEnIFVQCjEyOjQ3OjIyIHB1bHNlYXVkaW86IHNuZF9wY21fYXZhaWwoKSByZXR1cm5lZCBh
IHZhbHVlIHRoYXQgaXMgZXhjZXB0aW9uYWxseSBsYXJnZTogMTExNzI4MCBieXRlcyAoNjMzMyBt
cykuCjEyOjQ3OjIyIHdwYV9zdXBwbGljYW50OiBDb3VsZCBub3Qgc2V0IGludGVyZmFjZSB3bG8x
IGZsYWdzIChVUCk6IEludmFsaWQgYXJndW1lbnQKMTI6NDc6MjIga2VybmVsOiBydHdfcGNpIDAw
MDA6MGQ6MDAuMDogZmFpbGVkIHRvIHBvd2VyIG9uIG1hYwoxMjo0NzowNiBOZXR3b3JrTWFuYWdl
cjogPGVycm9yPiBbMTU5NDU0NzIyNi4zNjI2XSBzdXAtaWZhY2VbMHg1NWFlNGJjZDcxMDAsd2xv
MV06IGVycm9yIGFkZGluZyBpbnRlcmZhY2U6IHdwYV9zdXBwbGljYW50IGNvdWxkbid0IGdyYWIg
dGhpcyBpbnRlcmZhY2UuCjEyOjQ3OjA2IHdwYV9zdXBwbGljYW50OiB3bG8xOiBGYWlsZWQgdG8g
aW5pdGlhbGl6ZSBkcml2ZXIgaW50ZXJmYWNlCjEyOjQ3OjA2IGtlcm5lbDogcnR3X3BjaSAwMDAw
OjBkOjAwLjA6IGZhaWxlZCB0byBwb3dlciBvbiBtYWMKMTI6NDc6MDYgd3BhX3N1cHBsaWNhbnQ6
IENvdWxkIG5vdCBzZXQgaW50ZXJmYWNlIHdsbzEgZmxhZ3MgKFVQKTogSW52YWxpZCBhcmd1bWVu
dAoxMjo0NzowMyBrZXJuZWw6IHVzYiB1c2IyLXBvcnQ0OiB1bmFibGUgdG8gZW51bWVyYXRlIFVT
QiBkZXZpY2UKMTI6NDc6MDAgd3BhX3N1cHBsaWNhbnQ6IG5sODAyMTE6IENvdWxkIG5vdCBzZXQg
aW50ZXJmYWNlICd3bG8xJyBVUAoxMjo0NzowMCBrZXJuZWw6IHJ0d19wY2kgMDAwMDowZDowMC4w
OiBmYWlsZWQgdG8gcG93ZXIgb24gbWFjCjEyOjQ3OjAwIHdwYV9zdXBwbGljYW50OiBDb3VsZCBu
b3Qgc2V0IGludGVyZmFjZSB3bG8xIGZsYWdzIChVUCk6IEludmFsaWQgYXJndW1lbnQKMTI6NDY6
NTQga2VybmVsOiBydHdfcGNpIDAwMDA6MGQ6MDAuMDogZmFpbGVkIHRvIHBvd2VyIG9uIG1hYwox
Mjo0Njo1MCBrZXJuZWw6IHVzYiAyLTQ6IGRldmljZSBub3QgYWNjZXB0aW5nIGFkZHJlc3MgMiwg
ZXJyb3IgLTcxCg==
--000000000000f1da4e05aa3e6673
Content-Type: application/octet-stream; name=driver working with error
Content-Disposition: attachment; filename=driver working with error
Content-Transfer-Encoding: base64
Content-ID: <f_kcj3rmyj2>
X-Attachment-Id: f_kcj3rmyj2

MTU6Mzg6MjYga2VybmVsOiBydHdfcGNpIDAwMDA6MGQ6MDAuMDogZmFpbGVkIHRvIHNlbmQgaDJj
IGNvbW1hbmQKMTU6MzA6Mzkga2VybmVsOiBydHdfcGNpIDAwMDA6MGQ6MDAuMDogZmFpbGVkIHRv
IHNlbmQgaDJjIGNvbW1hbmQKMTU6MzA6Mzkga2VybmVsOiBydHdfcGNpIDAwMDA6MGQ6MDAuMDog
ZmFpbGVkIHRvIHNlbmQgaDJjIGNvbW1hbmQKMTU6MzA6MzYga2VybmVsOiBydHdfcGNpIDAwMDA6
MGQ6MDAuMDogZmFpbGVkIHRvIHNlbmQgaDJjIGNvbW1hbmQKMTU6MzA6MjMga2VybmVsOiBydHdf
cGNpIDAwMDA6MGQ6MDAuMDogZmFpbGVkIHRvIHNlbmQgaDJjIGNvbW1hbmQKMTU6MzA6MjIga2Vy
bmVsOiBydHdfcGNpIDAwMDA6MGQ6MDAuMDogZmFpbGVkIHRvIHNlbmQgaDJjIGNvbW1hbmQK
--000000000000f1da4e05aa3e6673
Content-Type: application/octet-stream; name=driver fail 2
Content-Disposition: attachment; filename=driver fail 2
Content-Transfer-Encoding: base64
Content-ID: <f_kcj3rmww1>
X-Attachment-Id: f_kcj3rmww1

MTI6Mzg6NTEga2VybmVsOiBydHdfcGNpIDAwMDA6MGQ6MDAuMDogZmFpbGVkIHRvIHBvd2VyIG9u
IG1hYwoxMjozODo1MSBOZXR3b3JrTWFuYWdlcjogPGVycm9yPiBbMTU5NDU0NjczMS43MjE4XSBz
dXAtaWZhY2VbMHg1NjM5ZDEyMTFhZTAsd2xvMV06IGVycm9yIGFkZGluZyBpbnRlcmZhY2U6IHdw
YV9zdXBwbGljYW50IGNvdWxkbid0IGdyYWIgdGhpcyBpbnRlcmZhY2UuCjEyOjM4OjUxIHdwYV9z
dXBwbGljYW50OiB3bG8xOiBGYWlsZWQgdG8gaW5pdGlhbGl6ZSBkcml2ZXIgaW50ZXJmYWNlCjEy
OjM4OjQ1IGtlcm5lbDogcnR3X3BjaSAwMDAwOjBkOjAwLjA6IGZhaWxlZCB0byBwb3dlciBvbiBt
YWMKMTI6Mzg6NDUgd3BhX3N1cHBsaWNhbnQ6IG5sODAyMTE6IENvdWxkIG5vdCBzZXQgaW50ZXJm
YWNlICd3bG8xJyBVUAoxMjozODoyOSBOZXR3b3JrTWFuYWdlcjogPGVycm9yPiBbMTU5NDU0Njcw
OS43NDE3XSBzdXAtaWZhY2VbMHg1NjM5ZDEyMTE5ZjAsd2xvMV06IGVycm9yIGFkZGluZyBpbnRl
cmZhY2U6IHdwYV9zdXBwbGljYW50IGNvdWxkbid0IGdyYWIgdGhpcyBpbnRlcmZhY2UuCjEyOjM4
OjI5IHdwYV9zdXBwbGljYW50OiB3bG8xOiBGYWlsZWQgdG8gaW5pdGlhbGl6ZSBkcml2ZXIgaW50
ZXJmYWNlCjEyOjM4OjI5IGtlcm5lbDogcnR3X3BjaSAwMDAwOjBkOjAwLjA6IGZhaWxlZCB0byBw
b3dlciBvbiBtYWMKMTI6Mzg6MjMgd3BhX3N1cHBsaWNhbnQ6IG5sODAyMTE6IENvdWxkIG5vdCBz
ZXQgaW50ZXJmYWNlICd3bG8xJyBVUAoxMjozODoyMyBrZXJuZWw6IHJ0d19wY2kgMDAwMDowZDow
MC4wOiBmYWlsZWQgdG8gcG93ZXIgb24gbWFjCjEyOjM4OjIzIHdwYV9zdXBwbGljYW50OiBDb3Vs
ZCBub3Qgc2V0IGludGVyZmFjZSB3bG8xIGZsYWdzIChVUCk6IEludmFsaWQgYXJndW1lbnQKMTI6
Mzg6MDcgd3BhX3N1cHBsaWNhbnQ6IHdsbzE6IEZhaWxlZCB0byBpbml0aWFsaXplIGRyaXZlciBp
bnRlcmZhY2UKMTI6Mzg6MDcgTmV0d29ya01hbmFnZXI6IDxlcnJvcj4gWzE1OTQ1NDY2ODcuMjc5
Nl0gc3VwLWlmYWNlWzB4NTYzOWQxMjExOTAwLHdsbzFdOiBlcnJvciBhZGRpbmcgaW50ZXJmYWNl
OiB3cGFfc3VwcGxpY2FudCBjb3VsZG4ndCBncmFiIHRoaXMgaW50ZXJmYWNlLgoxMjozODowNyB3
cGFfc3VwcGxpY2FudDogQ291bGQgbm90IHNldCBpbnRlcmZhY2Ugd2xvMSBmbGFncyAoVVApOiBJ
bnZhbGlkIGFyZ3VtZW50CjEyOjM4OjA3IGtlcm5lbDogcnR3X3BjaSAwMDAwOjBkOjAwLjA6IGZh
aWxlZCB0byBwb3dlciBvbiBtYWMKMTI6Mzg6MDEgd3BhX3N1cHBsaWNhbnQ6IG5sODAyMTE6IENv
dWxkIG5vdCBzZXQgaW50ZXJmYWNlICd3bG8xJyBVUAoxMjozODowMSBrZXJuZWw6IHJ0d19wY2kg
MDAwMDowZDowMC4wOiBmYWlsZWQgdG8gcG93ZXIgb24gbWFjCjEyOjM4OjAxIHdwYV9zdXBwbGlj
YW50OiBDb3VsZCBub3Qgc2V0IGludGVyZmFjZSB3bG8xIGZsYWdzIChVUCk6IEludmFsaWQgYXJn
dW1lbnQKMTI6Mzc6NTUga2VybmVsOiBydHdfcGNpIDAwMDA6MGQ6MDAuMDogZmFpbGVkIHRvIHBv
d2VyIG9uIG1hYwoxMjozNzo1MyBrZXJuZWw6IHVzYiB1c2IyLXBvcnQ0OiB1bmFibGUgdG8gZW51
bWVyYXRlIFVTQiBkZXZpY2UK
--000000000000f1da4e05aa3e6673--
