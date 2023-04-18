Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07B26E5D84
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 11:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjDRJfn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 05:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDRJfl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 05:35:41 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19772AD
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 02:35:41 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-51f6461aec5so292028a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 02:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1681810540; x=1684402540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBHDCl6z6oJovCNvjDxh1E2Kytz5KU1DPO3cB3Y5kC0=;
        b=fKUc5CdJ8+Mf6CmHcxop0V6ygsM95+snoENlzGoMxP/PmCoyBq2UWqdZAXEgdQWZ19
         xy9T0EoLtQRAVXeK2lGY3XX6KcfjIsIbH1JytTlVADkIfh3glDlaSRdUUUBLxbdMqesP
         7a08kVSTxATmYiFAlTVYjDhk/dx7wk2rIwiy8i2NOpiEuNouQRgCUWpt3Ys+hv8Kia2b
         6rS7oPTXrM79GSV36v8TO/yxXXeTxG3u8jjgEkOWr/znZ04BJr4AQU4+Jxww/UuKIDb3
         D+pg785dBoPksnOg8xm4nwM3lwkz5NcWbjPAHIlCaCtIqJPdTe0wuEvdDKn1SEP4X9e0
         BCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681810540; x=1684402540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBHDCl6z6oJovCNvjDxh1E2Kytz5KU1DPO3cB3Y5kC0=;
        b=WrP66XiNojZW1vad/7wXBEkeebVk+LEh+MwRgGwRtGWCYsTNxo6I/j80V5YjEep7ey
         CvqPFZ5W+DuYAQsOjRpp6MUF9FnqkttHyDTHTTfnBXPE4xtyHZYko0AaJSwf1+iVuM8+
         j4v1EAQ0E/5hNKOW/ZY/WWrOra6QnjQ2ZT2c+Nr6Q2R6v75L6enAdAGj2jIwDbR9XnaX
         L0/4O3hd7xSN69hu9v4gVGMdtATLLFBYFe5uzE4wfKmIQRKQV9jhrZDcZ9D3TSjp43On
         XFkNFWa8XoZScHMee5EYwgmAhIkK9n8fWxo4Z4idSuPfpLnM2TXACkSp1suhcbsYYtsY
         Pm6Q==
X-Gm-Message-State: AAQBX9f9/gq8/bQwBAH4gj35+xMs8IG9fIC1Zt1LOc+8UCH5oClfJFcK
        IWYtzvUsyK8oqtf3yfccPm3xRyPOIVmEYhmQk4dGgQ==
X-Google-Smtp-Source: AKy350bLgmod9zQU3mMT3TyLinWMqUG95Rh2K9AYMdWBVFTzdZvL9wg3Ril7H7BOthMpvnMS0UtF07YoHHXpAFfANAk=
X-Received: by 2002:a17:90b:1a92:b0:247:bab1:d901 with SMTP id
 ng18-20020a17090b1a9200b00247bab1d901mr1399753pjb.17.1681810540487; Tue, 18
 Apr 2023 02:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <1681762947-13882-1-git-send-email-quic_msinada@quicinc.com>
In-Reply-To: <1681762947-13882-1-git-send-email-quic_msinada@quicinc.com>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Tue, 18 Apr 2023 11:35:29 +0200
Message-ID: <CA+HBbNHB5dOgojaxm4RT_psrA8XQTt=4VubZ0xJv3HogDdMRig@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath11k: Remove disabling of 80+80 and 160 MHz
To:     Muna Sinada <quic_msinada@quicinc.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        P Praneesh <quic_ppranees@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Apr 17, 2023 at 10:23=E2=80=AFPM Muna Sinada <quic_msinada@quicinc.=
com> wrote:
>
> This is a regression fix for 80+80 and 160 MHz support bits being
> cleared, therefore not adverised. Remove disable of 80+80 and 160 MHz
> capability flags and assign valid center frequency 2 similar to
> VHT80_80.
>
> Fixes: 38dfe775d0ab ("wifi: ath11k: push MU-MIMO params from hostapd to h=
ardware")
> Reported-by: Robert Marko <robert.marko@sartura.hr>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217299
> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
> ---

Tested-by: Robert Marko <robert.marko@sartura.hr> #IPQ8074
WLAN.HK.2.9.0.1-01385-QCAHKSWPL_SILICONZ-1

Regards,
Robert
--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
