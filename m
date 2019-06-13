Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9095C44D62
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2019 22:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbfFMU0n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jun 2019 16:26:43 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43683 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfFMU0n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jun 2019 16:26:43 -0400
Received: by mail-lf1-f68.google.com with SMTP id j29so93721lfk.10
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2019 13:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QMHoky7BpIztbPIx9VbA7YF87db/FXoawkjiF+Gg/UI=;
        b=gFwRaPbCKhiv0u42PwplV3Bj1f7Avali+hQACaBrYB+tlXcOJNY2Jgu/SmyU9+7EAC
         bqGNoNM5nFM1GRweVuGNqrhGyGwtHc3SOiaIHhxwzlI5vHV5cmAGwGI4jFzMxFI1schZ
         JAlkcahqDrm6Rk25l81tdgOqs81OftBWbdvFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QMHoky7BpIztbPIx9VbA7YF87db/FXoawkjiF+Gg/UI=;
        b=qdgjTUqlHYDcTQ5NHW1sC/gx1OIKTqrOBBF4tAegl5wNjF18sRoYmEGU4u5IBKgrki
         oUeYqwM2UERnbKB8ZW/lWgZ4bXdkOC8PmNTGVpq8lm/diZj64WZ6N5Sp33P6L9ZK1Cod
         W5jihRNfjYPWlYgCQ+slN9dQF6fKvim6fe1UXZRhnsa3mfoMx5UGuSp/H0eM0rLytBBl
         J1SR8CKk23cm/0o1zypnfEfrym3IXBvpmuBad4TjwlgzCVwu588cQSnDtVg65ESR3FY8
         uj43/rnCEFx/9gkPHVayJvjy+XeIuoSWvA6gzlAbJ2hwa4DWa1Q1b/uRwWpGxHd9J1Dx
         cQdw==
X-Gm-Message-State: APjAAAXsI888+DcMPbcRO8cTfMkUzBnNiK9jrWgejvYxyyrAZCqxgVGi
        JHWg4oxbZ1ToCYbYH/ObUTDfpDq5rw8=
X-Google-Smtp-Source: APXvYqxfKXLC2f0eOBL3h87w4grXBsrd1V8YolNu3Zg2TgYegcSIsj6HwZ1dlCgVsRvvWTTVjxOQiQ==
X-Received: by 2002:ac2:4d17:: with SMTP id r23mr39829165lfi.130.1560457600944;
        Thu, 13 Jun 2019 13:26:40 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id e8sm150172lfc.27.2019.06.13.13.26.39
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 13:26:40 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id u10so84480lfm.12
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2019 13:26:39 -0700 (PDT)
X-Received: by 2002:ac2:5b0c:: with SMTP id v12mr32906784lfn.184.1560457599101;
 Thu, 13 Jun 2019 13:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190529125220.17066-1-tiwai@suse.de> <20190529125220.17066-3-tiwai@suse.de>
 <20190613174938.GA260350@google.com> <s5hmuile4mg.wl-tiwai@suse.de> <20190613183835.GA16432@google.com>
In-Reply-To: <20190613183835.GA16432@google.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 13 Jun 2019 13:26:27 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOCHsqmiEEDso2SzaiqkmrftdDvCm=auV-ucymWSXOPaA@mail.gmail.com>
Message-ID: <CA+ASDXOCHsqmiEEDso2SzaiqkmrftdDvCm=auV-ucymWSXOPaA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mwifiex: Abort at too short BSS descriptor element
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>, huangwen@venustech.com.cn,
        Solar Designer <solar@openwall.com>,
        Marcus Meissner <meissner@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jun 13, 2019 at 11:38 AM Brian Norris <briannorris@chromium.org> wrote:
> So, I might say:
>
>         /* Vendor IEs must at least contain the OUI. */
>         if (total_ie_len < offsetof(struct ieee80211_vendor_ie, oui_type))
>                 return -EINVAL;
>
>         /* If the IE still isn't long enough, it's not a match. */
>         if (element_len < sizeof(wpa_oui))
>                 continue;

That would of course need to be break, not continue, to properly skip
to the next IE.

Brian
