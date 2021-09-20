Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860DC412A54
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Sep 2021 03:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhIUBkQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Sep 2021 21:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhIUBiS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Sep 2021 21:38:18 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A75C0F26DB
        for <linux-wireless@vger.kernel.org>; Mon, 20 Sep 2021 12:17:09 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mv7-20020a17090b198700b0019c843e7233so707320pjb.4
        for <linux-wireless@vger.kernel.org>; Mon, 20 Sep 2021 12:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=cq5Af24UhMZNHdQJlYyjqZ7V5xSef6SgBEoLUBr0kiw=;
        b=Z0s7XBbrGdwT71ibog12i3KsvL7FN2ohQMD7MY81IzU11LvZiFGi5XFoc+1gXziDdm
         xj4CscuHmmm92yPAOvJXGg+ZfTTc8gKTnCEDqWqs8aW+AU8OdL/t8R1a2S14RC/sact4
         yf/mwz9OVrdM35ci5KCOeSvbOJRDMOnwTlApoPQrLSolQVdPmFjBfCQiOaKEC5SHU7U3
         ZsGmMstA51NesJ6IcaUJvVRmVnouonSdYEGYQsB/R8gADkhPWLAfA+Xtu2leSqDY/vjP
         lNyc4885QMsXEx3YVCuz9o7maVgDeTo9m11Rggc7g7ufuVIg2vSxOSjs6WoHJ/V0ayG0
         VSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=cq5Af24UhMZNHdQJlYyjqZ7V5xSef6SgBEoLUBr0kiw=;
        b=Q52qjXED9+YBWBN2lKcsAoLDNNTM1sK8gcH5Qk2qonsyPYDPtWPzycyWIZ+biz5Iuf
         2ftcljy3mQ9J7/dNwbKFqk24A9oAoZ+fGN9ZBVGDlJIiW2I6NevL3SYUY1DI7qtCWrWJ
         CIc0i2hK9fKbJ4q7JpaIPfrXi0bPPM8JkjnFuX9X0vgq1QXVlcoV9GUj4I8uUd4UNa9V
         3UxXUdISSntx59XHPoNNuk9qEQ1hzKQeXDGvqynN885GB79eX/O2I2RKJj0JRt7Zx18Z
         woCBfypHwKXgMan0HyRON2MD7SDuafv8FQBrWvdT7UCPFNnQJ4W3Zp5Wy4iHrfFL/rXT
         h5Ug==
X-Gm-Message-State: AOAM532TrE7Cz1ivEAnJpGMuIB2KwHxH0mQwiR+3MMPvBSHRJEpFdtLb
        di7k/dM8w9xboiOnr2v/Tp+4X+uW4/H5CGvjyBM=
X-Google-Smtp-Source: ABdhPJziMereuaOKhqEDpMmoPElWvhgrvrGiylv2osMSmtHgOAfXRxwqcr+Levacoid5t+/WXZ5LgJDmz7Mf9IFIBt4=
X-Received: by 2002:a17:902:8648:b029:129:dda4:ddc2 with SMTP id
 y8-20020a1709028648b0290129dda4ddc2mr24046888plt.4.1632165429094; Mon, 20 Sep
 2021 12:17:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:fd95:0:0:0:0 with HTTP; Mon, 20 Sep 2021 12:17:08
 -0700 (PDT)
Reply-To: info.moneygrampostunit@gmail.com
From:   Ngozi Akpla <barristeremmanuellayman2@gmail.com>
Date:   Mon, 20 Sep 2021 07:17:08 -1200
Message-ID: <CA+5h8NQwXQB8gB7SeN1W==1uAF6-iEouugguWzu4GTi3zc+WGw@mail.gmail.com>
Subject: attach
To:     bkoko002 <bkoko002@mail.ru>
Content-Type: multipart/mixed; boundary="0000000000009dc51805cc7220e2"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--0000000000009dc51805cc7220e2
Content-Type: text/plain; charset="UTF-8"



--0000000000009dc51805cc7220e2
Content-Type: application/rtf; name="Document.rtf"
Content-Disposition: attachment; filename="Document.rtf"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

e1xydGYxXGFuc2lcYW5zaWNwZzEyNTJcZGVmZjBcbm91aWNvbXBhdFxkZWZsYW5nMTAzM3tcZm9u
dHRibHtcZjBcZm5pbFxmY2hhcnNldDAgQ2FsaWJyaTt9fQ0Ke1wqXGdlbmVyYXRvciBSaWNoZWQy
MCAxMC4wLjEwMjQwfVx2aWV3a2luZDRcdWMxIA0KXHBhcmRcc2EyMDBcc2wyNzZcc2xtdWx0MVxm
MFxmczIyXGxhbmcxMiBHb29kIGRheSBLaW5kbHkgaW5mb3JtIG1lIGlmIHlvdSBnb3QgbXkgZmly
c3QgbGV0dGVyIGlzIHVyZ2VudCBwbGVhc2VccGFyDQp9DQoA
--0000000000009dc51805cc7220e2--
