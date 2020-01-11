Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A378138458
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2020 01:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731826AbgALA4p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Jan 2020 19:56:45 -0500
Received: from mail3.iservicesmail.com ([217.130.24.75]:13411 "EHLO
        mail3.iservicesmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731822AbgALA4o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Jan 2020 19:56:44 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Jan 2020 19:56:43 EST
IronPort-SDR: 7wDC7xHyIhGHqLHNA8zkNj0SEdSAj7UcmGv9X16p27qqsVJVQvB/Z6VeCBnANV1+OF4tRvNKx4
 i5zwEA+slR/w==
IronPort-PHdr: =?us-ascii?q?9a23=3AZxpQLRM9LnwyTrWLiyMl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/z5rarrMEGX3/hxlliBBdydt6sfzbCI7eu6ByQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Ngu6oATQu8UZn4dvK7s6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gysBMDI37X3YhdZ1jKNbuR6suRt/w5TMYIGSLvpxZL/dcs0DSW?=
 =?us-ascii?q?VfWMZdTjBMAp+gb4QVE+UBPfhXr4zjqFsIsRuyHBejBOX2xjFPgX/227M10u?=
 =?us-ascii?q?Q4HQ7Y2gwrAtYCvXrIoNnpMasfV/2+wqvVwjXZd/5Y1zfz6JLWfB4ivP+DUq?=
 =?us-ascii?q?5/f8XKxEkzFQ7KkkmcpZD5Mz+L0OkGrmiV7/BnVeKqk2MpsR9+oiSxycc2l4?=
 =?us-ascii?q?LGhoUVylbL9S5kx4s1PcO3SFJlbt6+HppQsCeaN4RtT8MiWGFnozo1xqcatp?=
 =?us-ascii?q?68eSgG0pQnxx3GZvGBboOG4QrjWf6PLTtlhn9pYq+zihiu/US61OHxWdO43V?=
 =?us-ascii?q?hKoydDj9LCrGoC1wbJ5ciCUvZ9+0Ch1iuR2A3L8eFEJFw0lbLcK5483r48jp?=
 =?us-ascii?q?oTvlrHHi/xgEj2ibWZdkQg+uiy9evnZqnqq5CGO49qjQHxL74hmsK4AeQ+LA?=
 =?us-ascii?q?cCRXaU+f+k2L3i+032XqlKg+UonqXEsp3WP9kXq6ClDwNPzIou5AyzAjmm3d?=
 =?us-ascii?q?gAmHkINlNFeBaJj4jzPFHOJej1De+hjFSwjjhr3f7HPrrnApXCNXXDkKzhcq?=
 =?us-ascii?q?1h5EJG1AUzytVf64hUCrECOP7zQFP+tMTEDh8lNAy52+LnCNR71oMDVmODG6?=
 =?us-ascii?q?GYMKLIsVCW4uIgPfKMZJQOtTbjJPgq+eTugWU6mVADZ6mp24UYaHSiEvRhOU?=
 =?us-ascii?q?WZbimkvtBUFWYMoxp7U+3whVmPSiV7eXm/ReQ/6ys9BYbgCp3MFbqgmLiQ4C?=
 =?us-ascii?q?DuJpBKa3oONVeKHj+8b4iYVu0TbySdItRrmTwHfbekQo4lkxqpsVmp5aBgK7?=
 =?us-ascii?q?/s9zEVr9rc0956r7nLmA0/7yNzCcu103qHRCd/mWZORzxgj/M3mlB01lrWiP?=
 =?us-ascii?q?swuPdfD9EGvKsRXw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HVAQAHbRpelyMYgtlMGBoBAQEBAQE?=
 =?us-ascii?q?BAQEDAQEBAREBAQECAgEBAQGBaAQBAQEBCwEBGwQBgSmBTVIgEpNQgU0fg0O?=
 =?us-ascii?q?LY4EAgx4VhgcUDIFbDQEBAQEBNQIBAYRATgEXgQ8kNQgOAgMNAQEFAQEBAQE?=
 =?us-ascii?q?FBAEBAhABAQEBAQYYBoVzgh0MHgEEAQEBAQMDAwEBDAGDXQcZDzlKTAEOAVO?=
 =?us-ascii?q?DBIJLAQEznXUBjQQNDQKFHYJJBAqBCYEaI4E2AYwYGoFBP4EjIYIrCAGCAYJ?=
 =?us-ascii?q?/ARIBbIJIglkEjUISIYEHiCmYF4JBBHaJTIwCgjcBD4gBhDEDEIJFD4EJiAO?=
 =?us-ascii?q?EToF9ozdXdAGBHnEzGoImGoEgTxgNiBuOLUCBFhACT4xbgjIBAQ?=
X-IPAS-Result: =?us-ascii?q?A2HVAQAHbRpelyMYgtlMGBoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBaAQBAQEBCwEBGwQBgSmBTVIgEpNQgU0fg0OLY4EAgx4VhgcUD?=
 =?us-ascii?q?IFbDQEBAQEBNQIBAYRATgEXgQ8kNQgOAgMNAQEFAQEBAQEFBAEBAhABAQEBA?=
 =?us-ascii?q?QYYBoVzgh0MHgEEAQEBAQMDAwEBDAGDXQcZDzlKTAEOAVODBIJLAQEznXUBj?=
 =?us-ascii?q?QQNDQKFHYJJBAqBCYEaI4E2AYwYGoFBP4EjIYIrCAGCAYJ/ARIBbIJIglkEj?=
 =?us-ascii?q?UISIYEHiCmYF4JBBHaJTIwCgjcBD4gBhDEDEIJFD4EJiAOEToF9ozdXdAGBH?=
 =?us-ascii?q?nEzGoImGoEgTxgNiBuOLUCBFhACT4xbgjIBAQ?=
X-IronPort-AV: E=Sophos;i="5.69,423,1571695200"; 
   d="scan'208";a="303831339"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail01.vodafone.es with ESMTP; 12 Jan 2020 01:51:40 +0100
Received: (qmail 8456 invoked from network); 11 Jan 2020 23:46:32 -0000
Received: from unknown (HELO 192.168.1.3) (quesosbelda@[217.217.179.17])
          (envelope-sender <peterwong@hsbc.com.hk>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-wireless@vger.kernel.org>; 11 Jan 2020 23:46:32 -0000
Date:   Sun, 12 Jan 2020 00:46:30 +0100 (CET)
From:   Peter Wong <peterwong@hsbc.com.hk>
Reply-To: Peter Wong <peterwonghsbchk@gmail.com>
To:     linux-wireless@vger.kernel.org
Message-ID: <32735613.172072.1578786391869.JavaMail.cash@217.130.24.55>
Subject: Investment opportunity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Greetings,
Please read the attached investment proposal and reply for more details.
Are you interested in loan?
Sincerely: Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

