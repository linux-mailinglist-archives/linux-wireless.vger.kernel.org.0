Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95969193C4E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 10:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgCZJvu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 05:51:50 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:33970 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbgCZJvu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 05:51:50 -0400
Received: by mail-wm1-f45.google.com with SMTP id 26so6971381wmk.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2020 02:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=MAoI7QOF8NVuu0x7uW7hTEyjxfsf+V2jo7BsecrUJ6M=;
        b=HkTPgborpBsVTU37oX0MjWwVW2Alm1LbkdDcbyKtVIi8PV2hIR4xB3FoBIVPVqwzAK
         +hDo1I3GKTpywVpeh/awS2tojILZdg1xFqGTtV2RNgW0cDSJbjul2jSV1ur6/a5Ba+0X
         bjaXnZyCmT2ScbFn22xL3103Yc6UeNHp2PY+7mMYxO43eDuhWHI0fsLAoKmbqi2yj73x
         D/W33apisXBLm0fnbEdp1lqqJo6uiEX7IekK1lh6eUjevQJ3dK2gDWywrJQ5gmukpgyP
         3dUBSg4va4u7ZCm/wU5zIPZkdPjv1tApdZmIfd8QRkAO1nCeiAj87c8Cvq6/Nin4Eh3f
         NmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MAoI7QOF8NVuu0x7uW7hTEyjxfsf+V2jo7BsecrUJ6M=;
        b=pNceRo6PRQ1xjdEnG7yurj+9dlRlcH8cv7/StHrgm1+a1okJmt0viFFxMT/myw467S
         LYoH0/+iOs38w+B87+5+J6I3SMHEWCCYbEQQN+KUeFPc0Y1lesliJ1V1LDEPHDDjFIUT
         DX9ByT5uGYBDEzIOela7vYjtFFZfQo/8cX4fLrMVUyZ0tU9LK0b/6DXFyX50F52yJQMP
         4HOjuxoSLWXv2bEKKdm2YEWOLfhY+eInR4khUuXLIZLQNLepuw8tmY/J3bXFGiIOBltQ
         mO92rXJp0fVYh6dw3Mf+rFXZCBB87nHOaNYD0LxtvAKubLWTViGO0D9V1KqN2Cy81w0B
         fwTg==
X-Gm-Message-State: ANhLgQ3zOwtsCr8G/3JTQLtRl2bTOrXJ86/he173zX4jCBi7NEoe0s4k
        AR+sx+Pb2op8IUuJKqrAiKYwE3yqiqQ+hiz+ozCHnvhC
X-Google-Smtp-Source: ADFU+vvTiv1bNxk7/ZEhOI5jisDwyri28S3wsEqv01b3P7ygytmkkjQMO46LHN7xXu65TyRETiv7G0MkjrVBB6VxL+o=
X-Received: by 2002:a1c:491:: with SMTP id 139mr2334351wme.21.1585216307612;
 Thu, 26 Mar 2020 02:51:47 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Wojciech_Jak=C3=B3bczyk?= <wja@semihalf.com>
Date:   Thu, 26 Mar 2020 10:51:31 +0100
Message-ID: <CAP99iBKW7KAjNMdpfxm0=tim4ieXWwzwKexBw=_gsXJsR1WMSg@mail.gmail.com>
Subject: hostapd, acs and iwlwifi
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I'm trying to get automatic channel selection with hostapd on an Intel
chipset (9260).

As I understand this combination is not supported currently - iwlwifi
iwl_mvm_mac_get_survey does not implement what's required by hostapd.
Has there been any attempts to implement this? Or plans? Is this a lot
of work, for someone not experienced in the driver?

Or are there any viable alternatives? Another approach to ACS in hostapd maybe?

Some implementation to get this is fine for me, I'm just wondering
what's the best approach. Also which would be more flexible in terms
of supporting other chipsets... Not sure what's the status of ACS
support in general. I've seen an old note that only some Atheros
drivers support it.

thanks,
wojtek
