Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406F837B59A
	for <lists+linux-wireless@lfdr.de>; Wed, 12 May 2021 07:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhELFu1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 May 2021 01:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhELFu0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 May 2021 01:50:26 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D288C061574
        for <linux-wireless@vger.kernel.org>; Tue, 11 May 2021 22:49:18 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id n61so7108535uan.2
        for <linux-wireless@vger.kernel.org>; Tue, 11 May 2021 22:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xqFkaU9Utqp73FaGe04Oz4Du8qXg1aN7oD22mTiDHFo=;
        b=mzhybC+snp1rVDwFsFOVsoSWSm+hBDcpwVReE8LlWL8c7W9IYDsUR44yL02NQXJusZ
         xcMeCPI9YkGaHXEus4W0DRJgYiZujTCTOkleM758S6rWUmm91E2xayeuxf1bfNRtvqRx
         QXSJNMb8YJzMcLpo+nP9JxevLi8te2M5xR0rdQq4301EbX7Mn7FqD5DIzdQvUQ2WWNYq
         XrzamMIfvCX2G4cXWpbRUlXcNp/e4OrYJjpMym1FOQCngSHPznnHKnelcwTgK61DXuqy
         8DFxC0Z/erZTTu1fvzcsIqyfwllckORzJawlKbQOKAplRAkefe0+3iOUTxWGaxY1x3Eh
         Oosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqFkaU9Utqp73FaGe04Oz4Du8qXg1aN7oD22mTiDHFo=;
        b=ZDya0FG8zquV13RpQeo5WWvpNMSFrlMJGM+l5j64rDH+VdEJCD/p03BU0t2hz19+Iu
         cKZBNUHLuJmubMUiA+yPDUswc4DTZKTP+CMfIk+JQYgzHbHSS0TDGYlzMPTnUoxPDykl
         AfKVI0f2MH4LEC4Y/XIBqKqh2XSap/kt98gcP4JROpgdENKpcEbujbiKD0jcKaLz1Aa3
         Cbmohi1+vTovlsLzWFMYTHRr7Dvmiw6ElYZtMn7PuTxqCSQKm+gmV4XlnNt+oIZ8a47u
         KUYO/ouI1OrBJVP/piOhqFBBzbnK6IEsK+pPzZP4iTYncuGBFQnl/KYT0AAMFmNeGR0/
         KPtw==
X-Gm-Message-State: AOAM531RCFhmzD08AQYo78o3G/2XGNH8XBn67xuxD8O4tCOOS9bGmYA7
        e70k+ntEAJGukkHJ6+D/619CXifz3ukwhJHnH2HLxq+Ec52q5Q==
X-Google-Smtp-Source: ABdhPJygNI/LXNZ/S//DaWGwxhnNyAsdb0iZYR9ZdSyklIznRPyXV2N1MQjGTz50gxqIa8N/dktJ6r63grC9sV50dqE=
X-Received: by 2002:ab0:3188:: with SMTP id d8mr29682400uan.111.1620798557275;
 Tue, 11 May 2021 22:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210412124328.24472-1-emmanuel.grumbach@intel.com> <20210420172755.12178-1-emmanuel.grumbach@intel.com>
In-Reply-To: <20210420172755.12178-1-emmanuel.grumbach@intel.com>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Wed, 12 May 2021 08:49:06 +0300
Message-ID: <CANUX_P0enDyHC_j9s2+w-a+mJgE4NqK=soBfbBLb+iA3O-42dQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mei: bus: add client dma interface
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        "Coelho, Luciano" <luciano.coelho@intel.com>,
        gregkh@linuxfoundation.org,
        Alexander Usyskin <alexander.usyskin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Greg,

On Tue, Apr 20, 2021 at 8:29 PM Emmanuel Grumbach
<emmanuel.grumbach@intel.com> wrote:
>
> From: Alexander Usyskin <alexander.usyskin@intel.com>
>
> Expose the client dma mapping via mei client bus interface.
> The client dma has to be mapped before the device is enabled,
> therefore we need to create device linking already during mapping
> and we need to unmap after the client is disable hence we need to
> postpone the unlink and flush till unmapping or when
> destroying the device.
>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Co-developed-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
> This is a another version of the patch:
> https://lore.kernel.org/lkml/20210206144325.25682-6-tomas.winkler@intel.com/
>
> Greg asked to route this patch through the wireless drivers tree:
> https://lore.kernel.org/lkml/YB6sIi61X5p6Dq6y@kroah.com/
> So here it is.
> ---

I think I fixed all the issues you raised on the previous version of the patch.
This series has been reviewed internally as well. The merge window is
now closed, can we move forward with this?

Thanks.
