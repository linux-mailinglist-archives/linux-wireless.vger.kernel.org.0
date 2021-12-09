Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C5046EA33
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 15:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbhLIOpu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 09:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbhLIOpu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 09:45:50 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5B8C061746
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 06:42:16 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id l25so20269888eda.11
        for <linux-wireless@vger.kernel.org>; Thu, 09 Dec 2021 06:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=E+VUcCP4ypJMbrZuxu++4BUCyHCy//YP6VJ3/gJoQuc=;
        b=FhkMP7KoAtAwj5VwR4v5ZylFTpX5gO1cKK1FNtAjTSxhVIfq6Z1xQXUKM1dkX9Mv/g
         A7ZhDr0f1Npe42nlUzdD2t9GuisgAneCQHzMh2hKlXW+8Hbo/VEwbTd4cXvbKe2PToAA
         9vNSRNSSSFbZrkXYBu+I7mzOzLrCWMwDLQaSYtKJ39x6toqtJhvcCnSbxHQeoDgiN3qk
         An9ibGy7+Y2+T1A9o5/Xs7Sz0Bo4Fc+mtLY8MTY+JRVwxKGtvDrKgQaVMB2zB9NAtc0Z
         ez8PNS+RhwzGRtpQiONznO+SRYX2G654pWKOewgkP2Yy4KrGK7rYLlxp8jOXvdlaLh7R
         umgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=E+VUcCP4ypJMbrZuxu++4BUCyHCy//YP6VJ3/gJoQuc=;
        b=WQNX57nXXW9dnHw1Aeha7VHyryKHebuyX0xB6ukN3OOTUWOsFQwYO4/6S0vAXkAOXv
         25IA8HOXfJRMMPbl2zPWn8mWmXnP+n2vLM7YysauBZNz98xPzvF9BYtWB6YCG9dUcACV
         zSVqaY8yjFemyrSGJh8NgPWRNJq+/iYwurDoEMPR90fgdu3FukR10bXSQGItQGtigORC
         w5N+q6BSwMkW9idQ6Up7eCzvpNnWHPQuRVpTwYonF1/VZMk5XU2pvfIYQCp03jkRaZg+
         3eGqzVQDE/lcqThNVAaVkxv3K7URMpiqn9oTvzG8sALI2Slc8wHnkWd/5xReNJ2AgvuE
         8wlw==
X-Gm-Message-State: AOAM532HhOxCmnn7/hUhiZJGHpQbF8+KXEP5CUXlmUfWewp2MJImwIIg
        cBTinerB/Y6ghcZRd/nCzeO9EBlY09tbX+wNrgoBgceiyK0=
X-Google-Smtp-Source: ABdhPJz5UYeFoPsmz5R1zq7IhAfP7Qh9PF0hVCih6mSrK+/hLTVaRWwMAB1cr7k/pTcqKAzkoA+r7hswDIVFqZJOp8U=
X-Received: by 2002:a17:907:6e1a:: with SMTP id sd26mr15921032ejc.529.1639060874722;
 Thu, 09 Dec 2021 06:41:14 -0800 (PST)
MIME-Version: 1.0
From:   Roberto Riggio <roberto.riggio@gmail.com>
Date:   Thu, 9 Dec 2021 15:41:03 +0100
Message-ID: <CAKkT90b_C+B-2RY2BDO9tiQJh_Vv8y95JuVGADhc+ML-bSqxmQ@mail.gmail.com>
Subject: Frame injection on ath9k
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

a while ago I wrote some patches for the frame injection section of
ath9k (the tx.c file). Now I wanted to refresh those patches for the
latest version of the driver but I saw that the code changed quite a
bit. Could somebody be so kind to provide me with some pointers about
where the frame injection at arbitrary rates from a radiotap header is
implemented now?

Thanks very much.

R.
