Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB33213BE4
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2019 21:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfEDTLM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 May 2019 15:11:12 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44894 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfEDTLL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 May 2019 15:11:11 -0400
Received: by mail-ed1-f67.google.com with SMTP id b8so10134663edm.11
        for <linux-wireless@vger.kernel.org>; Sat, 04 May 2019 12:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=WcxhAgw8WDvU3ud152po/wV56qFlyq6ha4UCMPsuo1o=;
        b=g3omv1xvZ8JG1O+yBpN9ylXgwt/WvBEQ6+qsh2OV9HpSDVEhCnNhg6qftQ2BfCrn7i
         D2nu3rqrXI9bIU/Lt5cU68YdRHr149kcV6dqetx0SYB3xkzKiPUg46s72hcAb0BxWEc1
         nLmyC4uCMykptoeapyo1MOWO9WKlWB/HVvUaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WcxhAgw8WDvU3ud152po/wV56qFlyq6ha4UCMPsuo1o=;
        b=L10LdUz4UJRok1MfP+mn5OJO9VsvuuMmR5d8z8OE0dPDIBDJ11jkFK+N229CsOi0Hv
         O1Q5nv4pnNwzFdhVaypUpM7pJdWGPNWEEKtsRrImALbcGPlkH5MKYWeWlxwe3IVjRjpz
         1Afb2gfsuptM+al8b6/zY1lG3JD821tJWV6eDwURbfczRZPZLV0vzsPLxqWXXYYTMGdT
         HtTx0fWlnZOltAwxOJ9hGaw+deOKc4NdsO+7FL3ajrxuqx9q2VZygHI0h9gXFiFKtNac
         AnR3qixYJXCXzRbZXweGoGKb6hv3H0PV+sBDURNQ+y8P2ojeyS3k67c3I3C5C1kesFOE
         /b2w==
X-Gm-Message-State: APjAAAXg8nlMkkAP0hP9yAsVpPOmWXwRz2H4a4A4+caa/dZNOY+ladLw
        Cdk3WtKmBXEoavxaUuuxGRx+NmPAuVvong==
X-Google-Smtp-Source: APXvYqzLgUjS54L/ju63S54v/MSaPLusRxM9P7AiWF3+06G1byNgBbeaacrNZzW1m7Ra717/0p3hQg==
X-Received: by 2002:a17:906:1f53:: with SMTP id d19mr11978649ejk.12.1556997069734;
        Sat, 04 May 2019 12:11:09 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id y12sm831873ejo.85.2019.05.04.12.11.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 12:11:09 -0700 (PDT)
Subject: Re: PROBLEM: brcmfmac's DMI-based fw file names break built-in fw
 loader
To:     Victor Bravo <1905@spmblk.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
References: <20190504162633.ldrz2nqfocg55grb@localhost>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <cce7604e-2b02-80ed-1df5-6f304cada0cb@broadcom.com>
Date:   Sat, 4 May 2019 21:11:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190504162633.ldrz2nqfocg55grb@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ Hans, Luis

On 5/4/2019 6:26 PM, Victor Bravo wrote:
> The brcmfmac driver seems to have partially fixed problems which
> prevented it to be used in shared system/kernel images for multiple
> hardware by trying to load it's <config>.txt as
> <config>.<dmi_sys_vendor>.<dmi_product_name>.txt first and then
> falling back to <config>.txt. Real-life example:
> 
> brcmfmac mmc1:0001:1: Direct firmware load for brcm/brcmfmac43340-sdio.ASUSTeK COMPUTER INC.-T100HAN.txt failed with
> error -2
> brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43340-sdio for chip
> BCM43340/2
> 
> Unfortunately this doesn't really help on systems which use static
> kernel with firmware blobs (and also text configuration files in case of
> brcmfmac) built-in using CONFIG_EXTRA_FIRMWARE, as CONFIG_EXTRA_FIRMWARE
> doesn't support spaces in file names - kernel build fails with
> 
> CONFIG_EXTRA_FIRMWARE="brcm/brcmfmac43340-sdio.bin brcm/brcmfmac43340-sdio.ASUSTeK COMPUTER INC.-T100HAN.txt"
> 
> for obvious reasons. So the only way here is to stay with good old
> brcmfmac43340-sdio.txt and support at most one brcmfmac-equipped machine
> per kernel image.
> 
> Please consider filtering the DMI strings and replacing spaces and
> possibly other invalid characters with underscores, and/or adding module
> parameter to allow passing the string from command line (using
> brcmfmac.tag=t100 or brcmfmac.board=t100 to make the module load
> brcmfmac43340-sdio.t100.txt seems nicer to me, and isn't prone to
> breaking when DMI strings change on BIOS update).

The intent of the DMI approach was to avoid end-users from passing 
module parameters for this. As to fixing DMI string usage patches are 
welcome.

> My brief grep-based research also suggest that strings retrieved
> by dmi_get_system_info() are passed to firmware loader without any
> checks for special character, /../ etc. I'm not sure whether this is
> considered to be proper & safe use, but if it's not, it may also have
> some security implications, as it allows attacker with access to DMI
> strings (using root rights/other OS/BIOS/physical access) to mess
> with kernel space or secure boot.

Hmm. Attackers with that kind of access can do bad is a gazillion ways.

> I would also really appreciate not allowing future brcm (and other)
> drivers to leave staging area before they fully support =y.

Define fully support. At the time we moved into the wireless tree 
(almost a decade ago) we did support =y. As such you could consider the 
DMI approach a regression, but I find that a bit harsh to say. Hans made 
a honest attempt and it is something that can be fixed. It can be you 
providing just that ;-)

Regards,
Arend
