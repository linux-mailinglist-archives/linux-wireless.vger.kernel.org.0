Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A24DC11A3B3
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2019 06:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfLKFUx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Dec 2019 00:20:53 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]:37354 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfLKFUw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Dec 2019 00:20:52 -0500
Received: by mail-qk1-f171.google.com with SMTP id m188so18659831qkc.4;
        Tue, 10 Dec 2019 21:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:disposition-notification-to:return-receipt-to:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :subject:to:cc:from:message-id;
        bh=i4HREvJEfUsHx/079OShSuaJBOAcThcz3a4tZvIC3mI=;
        b=s5CVPKVsTt3PcnMFYzYSztnCQ3s+B+3GsKvu37KlTBjG00M0+4xSCvySFUfj9F0Xx3
         ipCYrKMLL9UbGsmIVQXgHePtDe4RyC/IWb8QHEJRY75887mrLPOKjI2XXnYSeOibTG/W
         L922iga2n12nxEPiTYNK2lEmh4DFaN4xpYDSLYaxuxAC6ZQlSrgAleP+oZaRoTFQ4wqo
         m2jq4DhBe+GCta8dAwbayQHNQh6eIVE5jRL0r5reoXc0cjW/r8nBMhVx2P4ecau9Eizb
         C0KNRwKEs86gyqAQB6T2tVoGj+1Jwb0UEOcGj8iLMhzFnCmJd9XWT5VX2n4GWY02p9d0
         whPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:disposition-notification-to
         :return-receipt-to:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=i4HREvJEfUsHx/079OShSuaJBOAcThcz3a4tZvIC3mI=;
        b=nFzpeo7EG3Hm9VysVxpdlYvP3QBqmlYFbiT0iAPf538YQboadzu7y/RkegasnO9PgF
         fzrFDA2ef6UDR3IDu7OE0Lvr/SAOKOaur3UnXMpgNxOt+YN3Ux59lreT9lhy7US6OGwU
         ytJ0TP8PvXw5PDuGRyFmQ0vSehsumPP/SxjGvPYsDNhTW+L2yUCuwdcAz+dS+Wn4uXEc
         750Q9bmo//S6EO+fonAZHmp0TC1EWBiTcjRiQU+2KBmg1YNnzHg8GYKBSTciXffSh9NO
         eoDfRnpzcSm7MMnGya66xul55biiJJxqFOLeRkJkwzZ54vneKfnzet//1Bvumx7tgot2
         3wLQ==
X-Gm-Message-State: APjAAAVwz6uJdqs91uagyrZIveFVZFXmOhE2w/wTUQP8jx2qJEBOTNzD
        L5lAbmZJH5WsXO2vm2IdQQkS07Ap
X-Google-Smtp-Source: APXvYqyHkqU2kva1jgmKXR5IVyHDluXUeTGp5sRHeoZEctdRJ0WbeNPd6rkX9MgybPDrM5kuaTqvFw==
X-Received: by 2002:a37:6543:: with SMTP id z64mr1291143qkb.389.1576041651867;
        Tue, 10 Dec 2019 21:20:51 -0800 (PST)
Received: from [192.168.1.171] (pool-68-133-6-220.bflony.fios.verizon.net. [68.133.6.220])
        by smtp.gmail.com with ESMTPSA id t73sm333348qke.71.2019.12.10.21.20.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 21:20:51 -0800 (PST)
Date:   Wed, 11 Dec 2019 00:20:49 -0500
User-Agent: K-9 Mail for Android
In-Reply-To: <20191208203810.GA2920@system76-pc.localdomain>
References: <20190817041258.GA1641@chirva-slack.chirva-slack> <20191208203810.GA2920@system76-pc.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: PROBLEM: iwlwifi in 5.4 does not load firmware for
To:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
CC:     kernel list <linux-kernel@vger.kernel.org>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        linux-wireless@vger.kernel.org
From:   "A.C." <achirvasub@gmail.com>
Message-ID: <92F8571A-5CA6-4867-BB55-8D0B0A13732D@gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The problem persists with the new 5=2E5-rc1 compiled just now, again copyin=
g over the =2Econfig file and making 'oldconfig'=2E
