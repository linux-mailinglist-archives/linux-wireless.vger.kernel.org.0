Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E36F378EF0
	for <lists+linux-wireless@lfdr.de>; Mon, 10 May 2021 15:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhEJNc1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 May 2021 09:32:27 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:58793 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233966AbhEJMHn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 May 2021 08:07:43 -0400
Date:   Mon, 10 May 2021 12:06:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1620648387;
        bh=Ei22Qdqy0/xxKHttj6zeuzsoK4OdLUs5FIjKuDVEnYY=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:From;
        b=eP2+SPZCKVXrHoYIBCGX6OMIO82BZGcoVW8Ql1DDlioB+nF26aA/qrPaKmrlQjNi+
         esVhA8w+ocR66D3A0W4BEQdUn+Gdg2m6bBnRwcwa5ml4hVPZn3QkwmFeysckfOHSpD
         MsmU5tizAYiCPh7rQpdZW/gQpepmuTaLYswCbyBI=
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   rtl8821cerfe2 <rtl8821cerfe2@protonmail.com>
Reply-To: rtl8821cerfe2 <rtl8821cerfe2@protonmail.com>
Subject: Re: rtw88: Guaranteed system freeze with RTL8821CE with RFE 2 type
Message-ID: <1jmF9EMZn2ywrHSGrNCzOUSAzllw9ox-Da2zfbSTnTULlX8Ha8F211TfKuxITBBtkfxiU_R0w7zUeFLdtDj4ejp6qPnCIhFj2U-rsCVNlMg=@protonmail.com>
In-Reply-To: <65c86fe7-f1f1-445f-40c2-25ceaa4e4fb6@lwfinger.net>
References: <vWuRjLpNOkVGXHNeCL6phN5YDcd6Oljm1WgEMO4vA9aufK8MxzN5itvDnRjPBWHZN0geAbRLAzgIj36kAiNtdHh5vg2RjUH_TzuqZ7WSYeE=@protonmail.com> <65c86fe7-f1f1-445f-40c2-25ceaa4e4fb6@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Monday, May 10, 2021 4:16 AM, Larry Finger <Larry.Finger@lwfinger.net> w=
rote:
> The only splat that shows in either attachment is due to you not installi=
ng the
> regulatory database that sets the channels etc. for your domain. I do not=
 know
> what it is called for your distro - it is wireless-regdb on mine. It is u=
nlikely
> that this is the cause of your problem, but who knows?
>
> Larry

I installed the wireless-regdb package. The error message about
regulatory.db went away, but the system still froze.

I'll try the rtw_core parameter disable_lps_deep=3D1 now.
