Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7E1420981
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2019 16:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfEPO0U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 May 2019 10:26:20 -0400
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:38504 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726687AbfEPO0U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 May 2019 10:26:20 -0400
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 May 2019 10:26:18 EDT
Received: from pps.filterd (m0102629.ppops.net [127.0.0.1])
        by mx08-00252a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4GE66MO012296
        for <linux-wireless@vger.kernel.org>; Thu, 16 May 2019 15:17:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=pp; bh=+a/5tvCMElMjY1nTzPK6PTW3CCjmXXnkn/w+8GhgbYo=;
 b=01hHi8FfBDULuSWNHSIetXqszeUEjwgLxMtzJtnYWgzv43dvxLlxnyK+9PQa//Xzp4Nr
 mJneEb5IQ+W3AsO6zniO/oqJ7Y5LstHKkYLIiQz/eTaWvDYeN5XcbDd9N5Lgunu1KTxc
 c4CW8s07QnNfrg/uwF6eaAWJ4Gsy8Fo970YBIh0cONZGAHTc9nLbYpbRmT22vzA8fDwy
 RvfoRC3NTvd2KYyoDbfhlkdaUelM8As1c/PgEWcc9LYI2QO2FtVQb2wGXmL6nYbgDTkS
 qnhF1YvZmCdqmdZlCk7GZUxR5tLtVtcNskmDQHprZ1HPFSir6lGiQDSXt5BuyHnUzxn4 aw== 
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        by mx08-00252a01.pphosted.com with ESMTP id 2sdjvgau5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-wireless@vger.kernel.org>; Thu, 16 May 2019 15:17:55 +0100
Received: by mail-wm1-f71.google.com with SMTP id 20so1089813wma.2
        for <linux-wireless@vger.kernel.org>; Thu, 16 May 2019 07:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+a/5tvCMElMjY1nTzPK6PTW3CCjmXXnkn/w+8GhgbYo=;
        b=CtlBhr79P2tZsy2RtJ9QYZ+7rtSDOJ7DERblt4ntkcO0GyHzh9bO40aRC/ZxUr9vfc
         UDLcFCtreVD0ft9Gl0siBIWJvJKkMrgQWyigeLCZUTnAxPYQO6gQpRlmBb1oIUSMPDXm
         nbtNC5ETctQJnLfrW2adjvckDYcfQkzkZgZJikr3RTDM6v2c6fR4xf8gIxxArhcuSyI7
         42rkmNzQvH0yeXPEy6OFbDHSRqCheoYdg+/9Xl8n6GmRUbdRvD4mpJQPBOudmNH/QS03
         Fr13YIMZUQt5g1EYxgBe1ggsmALulF60Gv5IWEjQCBentwD7wFnX6bkNw/7dFdFr2WxA
         eiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+a/5tvCMElMjY1nTzPK6PTW3CCjmXXnkn/w+8GhgbYo=;
        b=VmNBYYgzPk4CDRGVrrOq4Kf3fR6SfIutbMZQ5yeSIPLJJBrP3KQYEdglskRnPx9uNq
         tQAZrYxga5B9EnzmnGRsyxkSfU4dSh93f8mglFkFpK6K6Sf89H/d7IOrBVvLeiv/lr1J
         aKkpT0FGbIrpe6xTcRphGQsKXtNKa+TwQehO/teLPfUI5+U8PNG0bMJTsQg4nYOIl4GS
         ac3Xb7iRQEJbCh393XxNRUf+FnVz1G+CaXTk4jexioekmZPeLZvQ9JLFXHlMnl/l5eqZ
         9EzU9MSXsrqeyXCjpBNQ3mhqPg4tFhQt40mD2uXgtELTlizSnmZ/cykDLn2xVj3dWhry
         ArCg==
X-Gm-Message-State: APjAAAV/LUP0xEFUA8fM4akH1UQM5YfSLmldqOO7ZIuttoCRa1jdW2pG
        +49Mq9oFZwEheYOYNmYlYksu998N7eglm6C7HcB6YKk1Z5yIWYw7jdeWLwtbpDCLlk4R36+G5ZC
        Q3m6hQvphrQUMOnfKSfNxcaPpbOBNmKzjPa5LPfPpq8A=
X-Received: by 2002:a1c:20d2:: with SMTP id g201mr26906936wmg.148.1558016274330;
        Thu, 16 May 2019 07:17:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzdUn66gYanQzxiWUmIT/4aeAN6CDTd/PzFDXX2QuqAtD0DimTjtV6GJG2aaB/7l2oExgUyNtdy5gR7C22yoNM=
X-Received: by 2002:a1c:20d2:: with SMTP id g201mr26906921wmg.148.1558016274111;
 Thu, 16 May 2019 07:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <b04655c7-5a6e-b510-5fcf-30ecca489882@broadcom.com>
In-Reply-To: <b04655c7-5a6e-b510-5fcf-30ecca489882@broadcom.com>
From:   James Hughes <james.hughes@raspberrypi.org>
Date:   Thu, 16 May 2019 15:17:43 +0100
Message-ID: <CAE_XsMKM5Q2obuKoVCBcpVtxGdhuEOp8a7nq=YP9ivNBOUz9Fg@mail.gmail.com>
Subject: Re: SPDX identifier
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-16_12:,,
 signatures=0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

https://www.kernel.org/doc/html/v4.17/process/license-rules.html
explains why the comment style differs between .c and .h

On Thu, 16 May 2019 at 12:36, Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> Hi Kalle, Thomas,
>
> I added SPDX tags in brcm80211 driver sources. Although it is a
> no-brainer I decided to run checkpatch for the changes and quirky stuff
> started to happen. For all files I added:
>
> // SPDX-License-Identifier
>
> but checkpatch started complaining I should use /* ... */ instead of //.
>
> WARNING: Improper SPDX comment style for
> 'drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h', please
> use '/*' instead
> #29: FILE: drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h:1:
> +// SPDX-License-Identifier: ISC
>
> So I edited all patches and ran again. And again it started complaining.
>
> WARNING: Improper SPDX comment style for
> 'drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.c', please use
> '//' instead
>
> So now I am in a bonkers state. It seems for header files we want /* */
> and for c files we want //. For real?
>
> This is on wireless-drivers-next so maybe it is already fixed, but I
> think this should be fixed.
>
> Regards,
> Arend



-- 
James Hughes
Principal Software Engineer,
Raspberry Pi (Trading) Ltd
