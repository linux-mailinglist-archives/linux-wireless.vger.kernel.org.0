Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B350418E716
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Mar 2020 07:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgCVGPs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Mar 2020 02:15:48 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:39121 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgCVGPs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Mar 2020 02:15:48 -0400
Received: by mail-il1-f180.google.com with SMTP id r5so5331649ilq.6
        for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2020 23:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1Dc8QYnu0Mt5l/DOa57MVk/OrasboSZuspfiudZBlxM=;
        b=PazIYCbrbBp0FrGatBwoh7ls1YaNBaaf7/zjhfSeCaoG8NUcyE5r4qhrUMraYF7+gJ
         LCbR/7HSKhP1OTs6WNmNCIJyIcgC+7c6Bu0jrtdDx/omp3NudafE9jxmQ+F0yeBcxTjZ
         uRpRbgYdWYsqD/IRfVZdFkteRONwRynmL95hn2m4uyQ9BpSOUjzPY8FuyY5eMDhBgBoE
         c0sRUzrMpULpMmPhxxbhZD9YxrzamjwfnBZQk8oG2/NBuOjJluw/wZqE1odUnbICCSj/
         pDysU1iIVkNLFf22eJUzfBpV7BJJvgNw+W6aGa2S5UWLAah9QecRmeHRx1SB7n4qqjWU
         j9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1Dc8QYnu0Mt5l/DOa57MVk/OrasboSZuspfiudZBlxM=;
        b=lkiSalnW6Q6a+ZdsgnmbS68cCdjBgv2q2ZSlfV97qljtAVg4BCKbm4PjSpKZSD/NTC
         +/F3OEFwT6ydM6Cc50DMpY0gQLi9johsIvOx1xKYWJm1ThbuprPweodbmGKNIvWMl5Lh
         KKf0fiG632LJFmk+yJqscqv5freM/S9dyk2suaNvjQAglFU43r8WOLEBXNyVAT7c0N8B
         k7fK8y+sOhMhC4/LRDN5tqS+pu4tuKHIPmHRzS3e9Z2WLneC1Jki5sEQB2VukjjTQkoQ
         WyWu2vJMl/5Kym+1vGEGXS/n+bEEzlgQq+NKGVGpJKKIaSMdn2ahL/nuj2vsgq6zlbJr
         6vUQ==
X-Gm-Message-State: ANhLgQ3g59pV+NKiTc+KaF4MxoelX0stLHQz0LzL5LjM2I+sgc7Qwynf
        kfqSg76g0lw3D9qTsEauJKApQpT2TK/BITmS6/0nzg==
X-Google-Smtp-Source: ADFU+vs/fWGAdA7GoSPxZXDOACKwWqiNYgZAvUuO+NracSDKYtANMgeUe632eAs+ueOgnuS1iBg8MdgG6ZFcDiONEqg=
X-Received: by 2002:a92:d60a:: with SMTP id w10mr16293478ilm.107.1584857747697;
 Sat, 21 Mar 2020 23:15:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:7714:0:0:0:0:0 with HTTP; Sat, 21 Mar 2020 23:15:47
 -0700 (PDT)
In-Reply-To: <BN7PR10MB2737FC3E7028D66FE34351C09AF20@BN7PR10MB2737.namprd10.prod.outlook.com>
References: <BN7PR10MB2737FC3E7028D66FE34351C09AF20@BN7PR10MB2737.namprd10.prod.outlook.com>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Sun, 22 Mar 2020 07:15:47 +0100
Message-ID: <CAKR_QVLLe2nssX3fz=xtPvM8ZQKwGpC4g=YOyUUkaniX_KB8QA@mail.gmail.com>
Subject: Re: Firmware Crashed
To:     Ming Chen <Ming.Chen@watchguard.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

can you try to boot it in another device and using some distro that
has 4.19 or later kernel without backports?
